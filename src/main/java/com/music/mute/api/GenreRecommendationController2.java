package com.music.mute.api;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import javax.servlet.http.HttpSession;
import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.AlbumSimplified;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;
@Controller
public class GenreRecommendationController2 {
    @Autowired
    private SpotifyApi spotifyApi;
    @Autowired
    private SpotifyPlaybackService playbackService;
    @GetMapping("/recommendations2")
    public String getGenreRecommendations(Model model, HttpSession session) {
        // 사용자의 Access Token을 세션에서 가져옴
        String accessToken = (String) session.getAttribute("accessToken");
        List<TrackWithImageUrl> recommendationsList = new ArrayList<>();
        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);
                // 사용자의 플레이리스트 목록 가져오기 (예시)
                final GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
                        .getListOfCurrentUsersPlaylists()
                        .limit(10)
                        .build();
                final CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();
                PlaylistSimplified[] playlists = playlistsFuture.join().getItems();
                // 특정 플레이리스트의 장르를 기반으로 음악 추천 받기 (예시)
                String playlistId = playlists[0].getId(); // 첫 번째 플레이리스트 사용 (예시)
                final GetRecommendationsRequest recommendationsRequest = spotifyApi
                        .getRecommendations()
                        .seed_genres("pop") // 원하는 장르를 나열
                        .limit(3)
                        .build();
                final CompletableFuture<Recommendations> recommendationsFuture = recommendationsRequest.executeAsync();
                Track[] recommendations = recommendationsFuture.join().getTracks();
                // 추천된 트랙 목록에 앨범 커버 이미지 URL 추가
                for (Track track : recommendations) {
                    String trackAlbumId = getAlbumId(track.getId(), accessToken);
                    String coverImageUrl = getAlbumCoverImageUrl(trackAlbumId, accessToken);
                 // TrackWithImageUrl 객체를 생성합니다.
                    TrackWithImageUrl newTrack = new TrackWithImageUrl(track, coverImageUrl);
                    recommendationsList.add(newTrack);
                }
                model.addAttribute("recommendations", recommendations);
            } catch (Exception e) {
                // 예외 처리: 사용자에게 친화적인 메시지 표시
                model.addAttribute("error", "음악 추천을 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage"; // 예시: 오류 페이지로 리다이렉트
            }
        } else {
            // Access Token이 없는 경우, 로그인 페이지로 리다이렉트 또는 에러 처리
            return "redirect:/login"; // 예시: 로그인 페이지로 리다이렉트
        }
        return "/recommendations2";
    }
    @GetMapping("/play/{trackId}")
    public String playTrack(@PathVariable String trackId, HttpSession session) throws ParseException {
        String accessToken = (String) session.getAttribute("accessToken");
        if (accessToken != null) {
            playbackService.startOrResumePlayback(accessToken, "spotify:track:" + trackId);
        }
        return "redirect:/recommendations2";
    }
    @GetMapping("/pause")
    public String pausePlayback(HttpSession session) throws ParseException {
        String accessToken = (String) session.getAttribute("accessToken");
        if (accessToken != null) {
            playbackService.pausePlayback(accessToken);
        }
        return "redirect:/recommendations2";
    }
    private String getAlbumId(String trackId, String accessToken) throws ParseException {
        try {
            // Spotify API를 초기화하고 트랙 정보를 가져옴
        	
            SpotifyApi spotifyApi = new SpotifyApi.Builder()
                    .setAccessToken(accessToken)
                    .build();
            GetTrackRequest getTrackRequest = spotifyApi
                    .getTrack(trackId)
                    .build();
            Track track = getTrackRequest.execute();
            // 트랙이 존재하면 앨범 ID 반환
            if (track != null) {
                AlbumSimplified album = track.getAlbum();
                if (album != null) {
                    return album.getId();
                }
            }
            // 앨범 ID를 찾을 수 없는 경우 예외 처리 또는 기본 값 반환
            return "default-album-id";
        } catch (IOException | SpotifyWebApiException e) {
            // 예외 처리
            e.printStackTrace();
            return "error-album-id";
        }
    }
    private String getAlbumCoverImageUrl(String albumId, String accessToken) throws ParseException {
        try {
            // Spotify API를 초기화하고 앨범 정보를 가져옴
            SpotifyApi spotifyApi = new SpotifyApi.Builder()
                    .setAccessToken(accessToken)
                    .build();
            GetAlbumRequest getAlbumRequest = spotifyApi
                    .getAlbum(albumId)
                    .build();
            Album album = getAlbumRequest.execute();
            // 앨범 정보에서 커버 이미지 URL을 가져옴
            if (album != null && album.getImages() != null && album.getImages().length > 0) {
                return album.getImages()[0].getUrl();
            }
            // 커버 이미지 URL을 찾을 수 없는 경우 예외 처리 또는 기본 값 반환
            return "default-cover-image-url";
        } catch (IOException | SpotifyWebApiException e) {
            // 예외 처리
            e.printStackTrace();
            return "error-cover-image-url";
        }
    }
    public class TrackWithImageUrl {
        private Track track;
        private String coverImageUrl;
        public TrackWithImageUrl(Track track, String coverImageUrl) {
            this.track = track;
            this.coverImageUrl = coverImageUrl;
        }
        // 다른 필요한 메서드들을 추가할 수 있음
        public String getCoverImageUrl() {
            return coverImageUrl;
        }
        public void setCoverImageUrl(String coverImageUrl) {
            this.coverImageUrl = coverImageUrl;
        }
        // Track 클래스의 다른 메서드들을 필요한 경우 여기에 추가
    }
}