/*
 * package com.music.mute.result;
 * 
 * import java.io.IOException; import java.util.ArrayList; import
 * java.util.Arrays; import java.util.List; import java.util.Locale; import
 * java.util.concurrent.CompletableFuture; import
 * java.util.concurrent.CompletionException;
 * 
 * import javax.servlet.http.HttpSession;
 * 
 * import org.apache.hc.core5.http.ParseException; import org.slf4j.Logger;
 * import org.slf4j.LoggerFactory; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.ExceptionHandler; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.PathVariable; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod;
 * 
 * import com.music.mute.api.SpotifyPlaybackService; import
 * com.music.mute.api.TrackWithImageUrlVO;
 * 
 * import se.michaelthelin.spotify.SpotifyApi; import
 * se.michaelthelin.spotify.exceptions.SpotifyWebApiException; import
 * se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext;
 * import se.michaelthelin.spotify.model_objects.miscellaneous.Device; import
 * se.michaelthelin.spotify.model_objects.specification.Album; import
 * se.michaelthelin.spotify.model_objects.specification.AlbumSimplified; import
 * se.michaelthelin.spotify.model_objects.specification.Paging; import
 * se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
 * import se.michaelthelin.spotify.model_objects.specification.Recommendations;
 * import se.michaelthelin.spotify.model_objects.specification.Track; import
 * se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest; import
 * se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
 * import se.michaelthelin.spotify.requests.data.player.
 * GetInformationAboutUsersCurrentPlaybackRequest; import
 * se.michaelthelin.spotify.requests.data.player.
 * GetUsersAvailableDevicesRequest; import
 * se.michaelthelin.spotify.requests.data.playlists.
 * GetListOfCurrentUsersPlaylistsRequest; import
 * se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;
 * 
 * @Controller public class ResultBalladController {
 * 
 * @Autowired private SpotifyApi spotifyApi;
 * 
 * @Autowired private SpotifyPlaybackService playbackService;
 * 
 * private static final Logger logger =
 * LoggerFactory.getLogger(ResultBalladController.class);
 * 
 * @GetMapping("/result_ballad") public String resultBallad(Model model,
 * HttpSession session) { String accessToken = (String)
 * session.getAttribute("accessToken"); List<TrackWithImageUrlVO>
 * recommendationsList = new ArrayList<>(); if (accessToken != null) { try {
 * spotifyApi.setAccessToken(accessToken); GetListOfCurrentUsersPlaylistsRequest
 * playlistsRequest = spotifyApi .getListOfCurrentUsersPlaylists() .limit(10)
 * .build(); CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture =
 * playlistsRequest.executeAsync(); PlaylistSimplified[] playlists =
 * playlistsFuture.join().getItems();
 * 
 * String playlistId = playlists[0].getId(); GetRecommendationsRequest
 * recommendationsRequest = spotifyApi .getRecommendations()
 * .seed_genres("ballad") .limit(3) .build(); CompletableFuture<Recommendations>
 * recommendationsFuture = recommendationsRequest.executeAsync(); Track[]
 * recommendations = recommendationsFuture.join().getTracks();
 * 
 * for (Track track : recommendations) { String trackAlbumId =
 * getAlbumId(track.getId(), accessToken); String coverImageUrl =
 * getAlbumCoverImageUrl(trackAlbumId, accessToken); TrackWithImageUrlVO
 * newTrack = new TrackWithImageUrlVO(track, coverImageUrl);
 * recommendationsList.add(newTrack); } model.addAttribute("recommendations",
 * recommendationsList);
 * 
 * // 추가: 메서드가 호출되었음을 로깅
 * System.out.println("getGenreRecommendations 메서드가 호출되었습니다.");
 * 
 * } catch (Exception e) { System.out.println("hi"+e);
 * model.addAttribute("error", "음악 추천을 가져오는 중에 오류가 발생했습니다."); return
 * "/errorPage"; } } else { return "redirect:/login"; } return
 * "result/result_ballad"; }
 * 
 * private Device getCurrentDevice(String accessToken) throws IOException,
 * SpotifyWebApiException, ParseException { try {
 * GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
 * .getInformationAboutUsersCurrentPlayback() .build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync();
 * 
 * CurrentlyPlayingContext playbackContext; try { playbackContext =
 * playbackFuture.join(); } catch (CompletionException e) { // 비동기 작업 중 예외 발생
 * Throwable cause = e.getCause(); if (cause instanceof IOException) { throw
 * (IOException) cause; } else if (cause instanceof SpotifyWebApiException) {
 * throw (SpotifyWebApiException) cause; } else if (cause instanceof
 * ParseException) { throw (ParseException) cause; } else { // 다른 예외 처리 throw e;
 * } }
 * 
 * // 비동기 작업이 성공한 경우에만 getDevice() 호출 return (playbackContext != null) ?
 * playbackContext.getDevice() : null; } catch (IOException |
 * SpotifyWebApiException | ParseException e) { e.printStackTrace(); // 예외를 다시
 * 던져서 상위에서 처리하도록 함 throw e;
 * 
 * } }
 * 
 * @ExceptionHandler(Exception.class) public String handleException(Exception e,
 * Model model) { e.printStackTrace(); model.addAttribute("error",
 * "알 수 없는 오류가 발생했습니다: " + e.getMessage()); return "/errorPage"; }
 * 
 * private List<TrackWithImageUrlVO> getGenreRecommendationTracks(String
 * accessToken) throws IOException, SpotifyWebApiException, ParseException {
 * GetRecommendationsRequest recommendationsRequest = spotifyApi
 * .getRecommendations() .seed_genres("ballad") .limit(3) .build();
 * Recommendations recommendations = recommendationsRequest.execute();
 * 
 * List<TrackWithImageUrlVO> recommendationList = new ArrayList<>(); for (Track
 * track : recommendations.getTracks()) { String trackAlbumId =
 * getAlbumId(track.getId(), accessToken); String coverImageUrl =
 * getAlbumCoverImageUrl(trackAlbumId, accessToken); TrackWithImageUrlVO
 * newTrack = new TrackWithImageUrlVO(track, coverImageUrl);
 * recommendationList.add(newTrack); }
 * 
 * return recommendationList; }
 * 
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
 * e.printStackTrace(); } return "redirect:/result_ballad"; }
 * 
 * 
 * @GetMapping("/pause") public String pausePlayback(HttpSession session) { try
 * { String accessToken = (String) session.getAttribute("accessToken"); if
 * (accessToken != null) { playbackService.pausePlayback(accessToken);
 * System.out.println("Pause playback"); } } catch (Exception e) {
 * e.printStackTrace(); } return "redirect:/result_ballad"; }
 * 
 * @GetMapping("/devices") public String getDevices(Model model, HttpSession
 * session) { String accessToken = (String) session.getAttribute("accessToken");
 * if (accessToken != null) { try { spotifyApi.setAccessToken(accessToken);
 * GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
 * .getInformationAboutUsersCurrentPlayback() .build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
 * playbackFuture.join();
 * 
 * // 현재 재생 중인 기기 가져오기 Device currentDevice = playbackContext.getDevice();
 * model.addAttribute("currentDevice", currentDevice);
 * 
 * // 추가: 모든 연결된 기기 가져오기 GetUsersAvailableDevicesRequest devicesRequest =
 * spotifyApi .getUsersAvailableDevices() .build(); CompletableFuture<Device[]>
 * devicesFuture = devicesRequest.executeAsync(); Device[] devices =
 * devicesFuture.join();
 * 
 * model.addAttribute("devices", Arrays.asList(devices));
 * 
 * // 추가: 메서드가 호출되었음을 로깅 System.out.println("getDevices 메서드가 호출되었습니다.");
 * 
 * } catch (Exception e) { model.addAttribute("error",
 * "기기 목록을 가져오는 중에 오류가 발생했습니다."); return "/errorPage"; } } else { return
 * "redirect:/login"; } return "/devices"; }
 * 
 * @GetMapping("/setVolume/{volume}") public String setVolume(@PathVariable int
 * volume, HttpSession session) throws ParseException { String accessToken =
 * (String) session.getAttribute("accessToken"); if (accessToken != null) {
 * playbackService.setVolume(accessToken, volume); } return
 * "redirect:/result_ballad"; }
 * 
 * private String getAlbumId(String trackId, String accessToken) throws
 * ParseException { try { SpotifyApi spotifyApi = new SpotifyApi.Builder()
 * .setAccessToken(accessToken) .build(); GetTrackRequest getTrackRequest =
 * spotifyApi .getTrack(trackId) .build(); Track track =
 * getTrackRequest.execute(); if (track != null) { AlbumSimplified album =
 * track.getAlbum(); if (album != null) { return album.getId(); } } return
 * "default-album-id"; } catch (IOException | SpotifyWebApiException e) {
 * e.printStackTrace(); return "error-album-id"; } }
 * 
 * private String getAlbumCoverImageUrl(String albumId, String accessToken)
 * throws ParseException { try { SpotifyApi spotifyApi = new
 * SpotifyApi.Builder() .setAccessToken(accessToken) .build(); GetAlbumRequest
 * getAlbumRequest = spotifyApi .getAlbum(albumId) .build(); Album album =
 * getAlbumRequest.execute(); if (album != null && album.getImages() != null &&
 * album.getImages().length > 0) { return album.getImages()[0].getUrl(); }
 * return "default-cover-image-url"; } catch (IOException |
 * SpotifyWebApiException e) { e.printStackTrace(); return
 * "error-cover-image-url"; } }
 * 
 * @GetMapping("/getCurrentPlayback") public String getCurrentPlayback(Model
 * model, HttpSession session) { String accessToken = (String)
 * session.getAttribute("accessToken"); if (accessToken != null) { try {
 * spotifyApi.setAccessToken(accessToken);
 * GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
 * .getInformationAboutUsersCurrentPlayback() .build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
 * playbackFuture.join();
 * 
 * // 현재 재생 중인 기기 가져오기 Device currentDevice = playbackContext.getDevice();
 * model.addAttribute("currentDevice", currentDevice);
 * 
 * // 추가: 모든 연결된 기기 가져오기 GetUsersAvailableDevicesRequest devicesRequest =
 * spotifyApi .getUsersAvailableDevices() .build(); CompletableFuture<Device[]>
 * devicesFuture = devicesRequest.executeAsync(); Device[] devices =
 * devicesFuture.join();
 * 
 * model.addAttribute("devices", Arrays.asList(devices));
 * 
 * // 추가: 메서드가 호출되었음을 로깅 System.out.println("getCurrentPlayback 메서드가 호출되었습니다.");
 * 
 * } catch (Exception e) { model.addAttribute("error",
 * "현재 재생 상태를 가져오는 중에 오류가 발생했습니다."); return "/errorPage"; } } else { return
 * "redirect:/login"; } return "/getCurrentPlayback"; }
 * 
 * }
 */