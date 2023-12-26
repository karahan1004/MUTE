package com.music.mute.result;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;

import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.mute.api.SpotifyPlaybackService;
import com.music.mute.api.TrackWithImageUrlVO;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext;
import se.michaelthelin.spotify.model_objects.miscellaneous.Device;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.AlbumSimplified;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.player.GetInformationAboutUsersCurrentPlaybackRequest;
import se.michaelthelin.spotify.requests.data.player.GetUsersAvailableDevicesRequest;
import se.michaelthelin.spotify.requests.data.playlists.CreatePlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

@Controller
public class AllResultController {

    @Autowired
    private SpotifyApi spotifyApi;

    @Autowired
    private SpotifyPlaybackService playbackService;

    private static final Logger logger = LoggerFactory.getLogger(AllResultController.class);

    @GetMapping("/result_ballad")
    public String resultBallad(Model model, HttpSession session) {
        return getResultPage(model, session, "folk");
    }

    @GetMapping("/result_classic")
    public String resultClassic(Model model, HttpSession session) {
        return getResultPage(model, session, "classic");
    }

    @GetMapping("/result_dance")
    public String resultDance(Model model, HttpSession session) {
        return getResultPage(model, session, "dance");
    }

	
	@GetMapping("/result_techno") 
	public String resultTechno(Model model, HttpSession session) { 
		return getResultPage(model, session, "techno"); 
	}
	 

    @GetMapping("/result_disco")
    public String resultDisco(Model model, HttpSession session) {
        return getResultPage(model, session, "disco");
    }

    @GetMapping("/result_hiphop")
    public String resultHipHop(Model model, HttpSession session) {
        return getResultPage(model, session, "hip hop");
    }

    @GetMapping("/result_indie")
    public String resultIndie(Model model, HttpSession session) {
        return getResultPage(model, session, "indie");
    }

    @GetMapping("/result_jazz")
    public String resultJazz(Model model, HttpSession session) {
        return getResultPage(model, session, "jazz");
    }

    @GetMapping("/result_rnb")
    public String resultRnb(Model model, HttpSession session) {
        return getResultPage(model, session, "rnb");
    }

    @GetMapping("/result_rock")
    public String resultRock(Model model, HttpSession session) {
        return getResultPage(model, session, "rock");
    }

    // 공통 메서드
    private String getResultPage(Model model, HttpSession session, String genre) {
        String accessToken = (String) session.getAttribute("accessToken");
        List<TrackWithImageUrlVO> recommendationsList = new ArrayList<>();
        
        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);
                GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
                        .getListOfCurrentUsersPlaylists()
                        .limit(10)
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
                
             /* model.addAttribute("recommendations", recommendations);
				model.addAttribute("recommendationsList", recommendationsList); JH:현재 수정 중*/
                
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


    private Device getCurrentDevice(String accessToken) throws IOException, SpotifyWebApiException, ParseException {
        try {
            GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
                    .getInformationAboutUsersCurrentPlayback()
                    .build();
            CompletableFuture<CurrentlyPlayingContext> playbackFuture = playbackRequest.executeAsync();

            CurrentlyPlayingContext playbackContext;
            try {
                playbackContext = playbackFuture.join();
            } catch (CompletionException e) {
                // 비동기 작업 중 예외 발생
                Throwable cause = e.getCause();
                if (cause instanceof IOException) {
                    throw (IOException) cause;
                } else if (cause instanceof SpotifyWebApiException) {
                    throw (SpotifyWebApiException) cause;
                } else if (cause instanceof ParseException) {
                    throw (ParseException) cause;
                } else {
                    // 다른 예외 처리
                    throw e;
                }
            }

            // 비동기 작업이 성공한 경우에만 getDevice() 호출
            return (playbackContext != null) ? playbackContext.getDevice() : null;
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            e.printStackTrace();
            // 예외를 다시 던져서 상위에서 처리하도록 함
            throw e;
            
        }
    }
    
    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        e.printStackTrace();
        model.addAttribute("error", "알 수 없는 오류가 발생했습니다: " + e.getMessage());
        return "/errorPage";
    }

    private List<TrackWithImageUrlVO> getGenreRecommendationTracks(String accessToken, String genre) throws IOException, SpotifyWebApiException, ParseException {
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

	/*
	 * @GetMapping("/play/{trackId}") public String playTrack(@PathVariable String
	 * trackId, HttpSession session) { try { String accessToken = (String)
	 * session.getAttribute("accessToken"); if (accessToken != null) { // 현재 사용자의 활성
	 * 디바이스 ID 가져오기 GetInformationAboutUsersCurrentPlaybackRequest playbackRequest =
	 * spotifyApi .getInformationAboutUsersCurrentPlayback() .build();
	 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
	 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
	 * playbackFuture.join();
	 * 
	 * Device currentDevice = playbackContext.getDevice(); String deviceId =
	 * (currentDevice != null) ? currentDevice.getId() : null;
	 * 
	 * // 노래 재생 시 디바이스 ID 사용 if (deviceId != null) {
	 * playbackService.startOrResumePlayback(accessToken, "spotify:track:" +
	 * trackId, deviceId); System.out.println("Play track: " + trackId); } else {
	 * System.out.println("No active device found."); } } } catch (Exception e) {
	 * e.printStackTrace(); } return "redirect:/result_"+genre; }
	 * 
	 * 
	 * @GetMapping("/pause") public String pausePlayback(HttpSession session) { try
	 * { String accessToken = (String) session.getAttribute("accessToken"); if
	 * (accessToken != null) { playbackService.pausePlayback(accessToken);
	 * System.out.println("Pause playback"); } } catch (Exception e) {
	 * e.printStackTrace(); } return "redirect:/result_"+genre; }
	 */
    
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
    
    @GetMapping("/getCurrentPlayback")
    public String getCurrentPlayback(Model model, HttpSession session) {
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
                System.out.println("getCurrentPlayback 메서드가 호출되었습니다.");

            } catch (Exception e) {
                model.addAttribute("error", "현재 재생 상태를 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage";
            }
        } else {
            return "redirect:/login";
        }
        return "/getCurrentPlayback";
    }
    
    //--------------------------------------------------
    @PostMapping("/addPlaylist")
    @ResponseBody
    public ResponseEntity<Map<String, String>> addPlaylist(Model model, HttpSession session,
            @RequestParam String playlistName) {
        String accessToken = (String) session.getAttribute("accessToken");
        Map<String, String> response = new HashMap<>();

        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);

                // 현재 사용자의 프로필 정보 가져오기
                final GetCurrentUsersProfileRequest profileRequest = spotifyApi.getCurrentUsersProfile().build();
                final CompletableFuture<User> privateUserFuture = profileRequest.executeAsync();
                User privateUser = privateUserFuture.join();
                String userId = privateUser.getId();

                // 새로운 플레이리스트 생성
                final CreatePlaylistRequest createPlaylistRequest = spotifyApi.createPlaylist(userId, playlistName)
                        .public_(false)
                        .build();
                final CompletableFuture<Playlist> playlistFuture = createPlaylistRequest.executeAsync();
                Playlist newPlaylist = playlistFuture.join();

                // 생성된 플레이리스트 정보를 응답에 추가
                response.put("playlistId", newPlaylist.getId());
                response.put("playlistName", newPlaylist.getName());
                
                // addPlaylist 메서드에서 플레이리스트 생성 후
                String playlistId = newPlaylist.getId();
                model.addAttribute("playlistId", playlistId);


                //return new ResponseEntity<>(response, HttpStatus.OK);
                return new ResponseEntity<>(Map.of("playlistId", newPlaylist.getId()), HttpStatus.OK);

            } catch (Exception e) {
                e.printStackTrace();
                return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
        }
    }

    
    @PostMapping("/addTrackToPlaylist")
	@ResponseBody
	public ResponseEntity<String> addTrackToPlaylist(@RequestParam String trackId, @RequestParam String playlistId,
			HttpSession session) {
		String accessToken = (String) session.getAttribute("accessToken");

		if (accessToken != null) {
			try {
				// 트랙을 플레이리스트에 추가하는 API 요청
				String[] uris = { "spotify:track:" + trackId }; // 트랙 URI를 String 배열로 전달
				spotifyApi.addItemsToPlaylist(playlistId, uris).build().execute();

				return new ResponseEntity<>("Track added to playlist successfully", HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<>("Failed to add track to playlist", HttpStatus.INTERNAL_SERVER_ERROR);
			}
		} else {
			return new ResponseEntity<>("User not authenticated", HttpStatus.UNAUTHORIZED);
		}
	}
    
    

}