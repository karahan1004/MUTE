package com.music.mute.api;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
import se.michaelthelin.spotify.requests.data.player.GetUsersAvailableDevicesRequest;
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
        String accessToken = (String) session.getAttribute("accessToken");
        List<TrackWithImageUrl> recommendationsList = new ArrayList<>();
        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);
                GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
                        .getListOfCurrentUsersPlaylists()
                        .limit(10)
                        .build();
                CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();
                PlaylistSimplified[] playlists = playlistsFuture.join().getItems();

                String playlistId = playlists[0].getId();
                GetRecommendationsRequest recommendationsRequest = spotifyApi
                        .getRecommendations()
                        .seed_genres("dance")
                        .limit(3)
                        .build();
                CompletableFuture<Recommendations> recommendationsFuture = recommendationsRequest.executeAsync();
                Track[] recommendations = recommendationsFuture.join().getTracks();

                for (Track track : recommendations) {
                    String trackAlbumId = getAlbumId(track.getId(), accessToken);
                    String coverImageUrl = getAlbumCoverImageUrl(trackAlbumId, accessToken);
                    TrackWithImageUrl newTrack = new TrackWithImageUrl(track, coverImageUrl);
                    recommendationsList.add(newTrack);
                }
                model.addAttribute("recommendations", recommendationsList);

                // 추가: 메서드가 호출되었음을 로깅
                System.out.println("getGenreRecommendations 메서드가 호출되었습니다.");

            } catch (Exception e) {
                model.addAttribute("error", "음악 추천을 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage";
            }
        } else {
            return "redirect:/login";
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

    @GetMapping("/previous")
    public String playPreviousTrack(HttpSession session) throws ParseException {
        String accessToken = (String) session.getAttribute("accessToken");
        if (accessToken != null) {
            playbackService.playPreviousTrack(accessToken);
        }
        return "redirect:/recommendations2";
    }

    @GetMapping("/next")
    public String playNextTrack(HttpSession session) throws ParseException {
        String accessToken = (String) session.getAttribute("accessToken");
        if (accessToken != null) {
            playbackService.playNextTrack(accessToken);
        }
        return "redirect:/recommendations2";
    }
    
    @GetMapping("/devices")
    public String getDevices(Model model, HttpSession session) {
        String accessToken = (String) session.getAttribute("accessToken");
        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);
                GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
                        .getInformationAboutUsersCurrentPlayback()
                        .build();
                CompletableFuture<CurrentlyPlayingContext> playbackFuture = playbackRequest.executeAsync();
                CurrentlyPlayingContext playbackContext = playbackFuture.join();

                // 현재 재생 중인 기기 가져오기
                Device currentDevice = playbackContext.getDevice();
                model.addAttribute("currentDevice", currentDevice);

                // 추가: 모든 연결된 기기 가져오기
                GetUsersAvailableDevicesRequest devicesRequest = spotifyApi
                        .getUsersAvailableDevices()
                        .build();
                CompletableFuture<Device[]> devicesFuture = devicesRequest.executeAsync();
                Device[] devices = devicesFuture.join();

                model.addAttribute("devices", Arrays.asList(devices));

                // 추가: 메서드가 호출되었음을 로깅
                System.out.println("getDevices 메서드가 호출되었습니다.");

            } catch (Exception e) {
                model.addAttribute("error", "기기 목록을 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage";
            }
        } else {
            return "redirect:/login";
        }
        return "/devices";
    }


    private String getAlbumId(String trackId, String accessToken) throws ParseException {
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

    private String getAlbumCoverImageUrl(String albumId, String accessToken) throws ParseException {
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

    public class TrackWithImageUrl {
    	private Track track;
        private String coverImageUrl;
        private String name;
        private String artistName;
        private String albumImageUrl;
        private String uri;

        public TrackWithImageUrl(Track track, String coverImageUrl) {
            this.track = track;
            this.coverImageUrl = coverImageUrl;
            this.name = track.getName();
            this.artistName = track.getArtists()[0].getName();
            this.uri = track.getUri();
        }

        public String getCoverImageUrl() {
            return coverImageUrl;
        }

        public void setCoverImageUrl(String coverImageUrl) {
            this.coverImageUrl = coverImageUrl;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getArtistName() {
            return artistName;
        }

        public void setArtistName(String artistName) {
            this.artistName = artistName;
        }

        public String getAlbumImageUrl() {
            return albumImageUrl;
        }

        public void setAlbumImageUrl(String albumImageUrl) {
            this.albumImageUrl = albumImageUrl;
        }

        public String getUri() {
            return uri;
        }

        public void setUri(String uri) {
            this.uri = uri;
        }
    }
}
