package com.music.mute.result;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;

import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.music.mute.api.SpotifyPlaybackService;
import com.music.mute.api.TrackWithImageUrlVO;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext;
import se.michaelthelin.spotify.model_objects.miscellaneous.Device;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.AlbumSimplified;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.player.GetInformationAboutUsersCurrentPlaybackRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;

@Service
public class ResultServiceImpl implements ResultService {

	@Autowired
    private SpotifyApi spotifyApi;

    @Autowired
    private SpotifyPlaybackService playbackService;

	@Override
	public String getResultPage(Model model, HttpSession session, String genre) {
		String accessToken = (String) session.getAttribute("accessToken");
        List<TrackWithImageUrlVO> recommendationsList = new ArrayList<>();

        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);
             // 현재 재생 중인 디바이스의 정보 가져오기
				Device currentDevice = getCurrentDevice(accessToken);
				model.addAttribute("currentDevice", currentDevice);

                GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
                        .getListOfCurrentUsersPlaylists()
						/* .limit(10) */
                        .build();
                CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();
                PlaylistSimplified[] playlists = playlistsFuture.join().getItems();

                model.addAttribute("playlists", playlists);

                String playlistId = playlists[0].getId();
                GetRecommendationsRequest recommendationsRequest = spotifyApi
                        .getRecommendations()
                        .seed_genres(genre)
                        .limit(3)
                        .build();
                CompletableFuture<Recommendations> recommendationsFuture = recommendationsRequest.executeAsync();
                Track[] recommendations = recommendationsFuture.join().getTracks();

                for (Track track : recommendations) {
                    String trackAlbumId = getAlbumId(track.getId(), accessToken);
                    String coverImageUrl = getAlbumCoverImageUrl(trackAlbumId, accessToken);
                    TrackWithImageUrlVO newTrack = new TrackWithImageUrlVO(track, coverImageUrl);
                    recommendationsList.add(newTrack);

                }

				model.addAttribute("recommendations", recommendationsList);
                System.out.println("getGenreRecommendations 메서드가 호출되었습니다.");
                System.out.println("Recommendations List: " + recommendationsList);

            } catch (Exception e) {
                System.out.println("hi" + e);
                model.addAttribute("error", "음악 추천을 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage";
            }
        } else {
            return "redirect:/login";
        }

        // 여기서 페이지 정보에 따라 다른 결과 페이지를 반환
        return "result/result_" + genre;
	}

	@Override
	public Device getCurrentDevice(String accessToken) throws IOException, SpotifyWebApiException, ParseException {
		try {
			GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
					.getInformationAboutUsersCurrentPlayback().build();
			CompletableFuture<CurrentlyPlayingContext> playbackFuture = playbackRequest.executeAsync();
			CurrentlyPlayingContext playbackContext = null;
			try {
				playbackContext = playbackFuture.join();
			} catch (CompletionException e) { // 비동기 작업 중 예외 발생
				Throwable cause = e.getCause();
				if (cause instanceof IOException) {
					throw (IOException) cause;
				} else if (cause instanceof SpotifyWebApiException) {
					throw (SpotifyWebApiException) cause;
				} else if (cause instanceof ParseException) {
					throw (ParseException) cause;
				} else { // 다른 예외 처리 throw e;
				}
			}
			if (playbackContext != null)
				return playbackContext.getDevice();
			else
				return null;
		} catch (IOException | SpotifyWebApiException | ParseException e) {
			e.printStackTrace();
			// 예외를 다시 던져서 상위에서 처리하도록 함
			throw e;
		}
	}

	@Override
	@ExceptionHandler(Exception.class)
	public String handleException(Exception e, Model model) {
		e.printStackTrace();
		model.addAttribute("error", "알 수 없는 오류가 발생했습니다: " + e.getMessage());
		return "/errorPage";
	}

	@Override
	public List<TrackWithImageUrlVO> getGenreRecommendationTracks(String accessToken, String genre)throws IOException, SpotifyWebApiException, ParseException  {
		GetRecommendationsRequest recommendationsRequest = spotifyApi
                .getRecommendations()
                .seed_genres(genre)
                .limit(3)
                .build();
        Recommendations recommendations = recommendationsRequest.execute();

        List<TrackWithImageUrlVO> recommendationList = new ArrayList<>();
        for (Track track : recommendations.getTracks()) {
            String trackAlbumId = getAlbumId(track.getId(), accessToken);
            String coverImageUrl = getAlbumCoverImageUrl(trackAlbumId, accessToken);
            TrackWithImageUrlVO newTrack = new TrackWithImageUrlVO(track, coverImageUrl);
            recommendationList.add(newTrack);
        }

        return recommendationList;
	}

	@Override
	public String getAlbumId(String trackId, String accessToken) throws ParseException {
		 try {
	            SpotifyApi spotifyApi = new SpotifyApi.Builder()
	                    .setAccessToken(accessToken)
	                    .build();
	            GetTrackRequest getTrackRequest = spotifyApi
	                    .getTrack(trackId)
	                    .build();
	            Track track = getTrackRequest.execute();
	            if (track != null) {
	                AlbumSimplified album = track.getAlbum();
	                if (album != null) {
	                    return album.getId();
	                }
	            }
	            return "default-album-id";
	        } catch (IOException | SpotifyWebApiException e) {
	            e.printStackTrace();
	            return "error-album-id";
	        }
	}

	@Override
	public String getAlbumCoverImageUrl(String albumId, String accessToken) throws ParseException {
		 try {
	            SpotifyApi spotifyApi = new SpotifyApi.Builder()
	                    .setAccessToken(accessToken)
	                    .build();
	            GetAlbumRequest getAlbumRequest = spotifyApi
	                    .getAlbum(albumId)
	                    .build();
	            Album album = getAlbumRequest.execute();
	            if (album != null && album.getImages() != null && album.getImages().length > 0) {
	                return album.getImages()[0].getUrl();
	            }
	            return "default-cover-image-url";
	        } catch (IOException | SpotifyWebApiException e) {
	            e.printStackTrace();
	            return "error-cover-image-url";
	        }
	}

}