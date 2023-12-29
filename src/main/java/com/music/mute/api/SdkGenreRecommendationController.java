/*
 * package com.music.mute.api; import java.io.IOException; import
 * java.util.ArrayList; import java.util.Arrays; import java.util.List; import
 * java.util.concurrent.CompletableFuture; import
 * java.util.concurrent.CompletionException; import
 * javax.servlet.http.HttpSession; import
 * org.apache.hc.core5.http.ParseException; import org.slf4j.Logger; import
 * org.slf4j.LoggerFactory; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.ExceptionHandler; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.PathVariable; import
 * se.michaelthelin.spotify.SpotifyApi; import
 * se.michaelthelin.spotify.exceptions.SpotifyWebApiException; import
 * se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext;
 * import se.michaelthelin.spotify.model_objects.miscellaneous.Device; import
 * se.michaelthelin.spotify.model_objects.specification.Album; import
 * se.michaelthelin.spotify.model_objects.specification.AlbumSimplified; import
 * se.michaelthelin.spotify.model_objects.specification.Recommendations; import
 * se.michaelthelin.spotify.model_objects.specification.Track; import
 * se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest; import
 * se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
 * import se.michaelthelin.spotify.requests.data.player.
 * GetInformationAboutUsersCurrentPlaybackRequest; import
 * se.michaelthelin.spotify.requests.data.player.
 * GetUsersAvailableDevicesRequest; import
 * se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;
 * 
 * @Controller public class SdkGenreRecommendationController {
 * 
 * @Autowired private SpotifyApi spotifyApi;
 * 
 * @Autowired private SpotifyPlaybackService playbackService; private static
 * final Logger logger =
 * LoggerFactory.getLogger(SdkGenreRecommendationController.class);
 * 
 * @GetMapping("/sdkrecommendations") public String
 * getGenreRecommendations(Model model, HttpSession session) { String
 * accessToken = (String) session.getAttribute("accessToken");
 * List<TrackWithImageUrlVO> recommendationsList = new ArrayList<>(); if
 * (accessToken != null) { try { spotifyApi.setAccessToken(accessToken); // 현재
 * 재생 중인 디바이스의 정보 가져오기 Device currentDevice = getCurrentDevice(accessToken);
 * model.addAttribute("currentDevice", currentDevice); // 음악 추천 목록 가져오기
 * List<TrackWithImageUrlVO> recommendations =
 * getGenreRecommendationTracks(accessToken);
 * model.addAttribute("recommendations", recommendations); // 메서드가 호출되었음을 로깅
 * System.out.println("getGenreRecommendations 메서드가 호출되었습니다."); } catch
 * (Exception e) { e.printStackTrace(); model.addAttribute("error",
 * "음악 추천을 가져오는 중에 오류가 발생했습니다."); return "/errorPage"; } } else { return
 * "redirect:/login"; } return "/sdkrecommendations"; } private Device
 * getCurrentDevice(String accessToken) throws IOException,
 * SpotifyWebApiException, ParseException { try {
 * GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
 * .getInformationAboutUsersCurrentPlayback().build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
 * null; try { playbackContext = playbackFuture.join(); } catch
 * (CompletionException e) { // 비동기 작업 중 예외 발생 Throwable cause = e.getCause();
 * if (cause instanceof IOException) { throw (IOException) cause; } else if
 * (cause instanceof SpotifyWebApiException) { throw (SpotifyWebApiException)
 * cause; } else if (cause instanceof ParseException) { throw (ParseException)
 * cause; } else { // 다른 예외 처리 throw e; } } if (playbackContext != null) return
 * playbackContext.getDevice(); else return null; } catch (IOException |
 * SpotifyWebApiException | ParseException e) { e.printStackTrace(); // 예외를 다시
 * 던져서 상위에서 처리하도록 함 throw e; } }
 * 
 * private Device getCurrentDevice(String accessToken) throws IOException,
 * SpotifyWebApiException, ParseException {
 * GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
 * .getInformationAboutUsersCurrentPlayback() .build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
 * playbackFuture.join(); return (playbackContext != null) ?
 * playbackContext.getDevice() : null; }
 * 
 * @ExceptionHandler(Exception.class) public String handleException(Exception e,
 * Model model) { e.printStackTrace(); model.addAttribute("error",
 * "알 수 없는 오류가 발생했습니다: " + e.getMessage()); return "/errorPage"; } private
 * List<TrackWithImageUrlVO> getGenreRecommendationTracks(String accessToken)
 * throws IOException, SpotifyWebApiException, ParseException {
 * GetRecommendationsRequest recommendationsRequest =
 * spotifyApi.getRecommendations().seed_genres("dance").limit(3) .build();
 * Recommendations recommendations = recommendationsRequest.execute();
 * List<TrackWithImageUrlVO> recommendationList = new ArrayList<>(); for (Track
 * track : recommendations.getTracks()) { String trackAlbumId =
 * getAlbumId(track.getId(), accessToken); String coverImageUrl =
 * getAlbumCoverImageUrl(trackAlbumId, accessToken); TrackWithImageUrlVO
 * newTrack = new TrackWithImageUrlVO(track, coverImageUrl);
 * recommendationList.add(newTrack); } return recommendationList; }
 * 
 * @GetMapping("/play/{trackId}") public String playTrack(@PathVariable String
 * trackId, HttpSession session) { try { String accessToken = (String)
 * session.getAttribute("accessToken"); if (accessToken != null) { // 현재 사용자의 활성
 * 디바이스 ID 가져오기 GetInformationAboutUsersCurrentPlaybackRequest playbackRequest =
 * spotifyApi .getInformationAboutUsersCurrentPlayback().build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
 * playbackFuture.join(); Device currentDevice = playbackContext.getDevice();
 * String deviceId = (currentDevice != null) ? currentDevice.getId() : null;
 * session.setAttribute("deviceId", deviceId);
 * 
 * System.out.println("device: " + deviceId); // 노래 재생 시 디바이스 ID 사용 if (deviceId
 * != null) { playbackService.startOrResumePlayback(accessToken,
 * "spotify:track:" + trackId, deviceId); System.out.println("Play track: " +
 * trackId); } else { System.out.println("No active device found."); } } } catch
 * (Exception e) { e.printStackTrace(); } return "redirect:/sdkrecommendations";
 * }
 * 
 * @GetMapping("/pause") public String pausePlayback(HttpSession session) { try
 * { String accessToken = (String) session.getAttribute("accessToken"); if
 * (accessToken != null) { // 현재 사용자의 활성 디바이스 ID 가져오기
 * GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
 * .getInformationAboutUsersCurrentPlayback().build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
 * playbackFuture.join(); Device currentDevice = playbackContext.getDevice();
 * String deviceId = (currentDevice != null) ? currentDevice.getId() : null; //
 * 세션에 저장된 액세스 토큰 및 디바이스 ID를 사용하여 pausePlayback 호출
 * playbackService.pausePlayback(accessToken, deviceId);
 * System.out.println("Pause playback"); } } catch (Exception e) {
 * e.printStackTrace(); } return "redirect:/sdkrecommendations"; }
 * 
 * @GetMapping("/previous") public String playPreviousTrack(HttpSession session)
 * throws ParseException { String accessToken = (String)
 * session.getAttribute("accessToken"); if (accessToken != null) {
 * playbackService.playPreviousTrack(accessToken); } return
 * "redirect:/sdkrecommendations"; }
 * 
 * @GetMapping("/next") public String playNextTrack(HttpSession session) throws
 * ParseException { String accessToken = (String)
 * session.getAttribute("accessToken"); if (accessToken != null) {
 * playbackService.playNextTrack(accessToken); } return
 * "redirect:/sdkrecommendations"; }
 * 
 * @GetMapping("/devices") public String getDevices(Model model, HttpSession
 * session) { String accessToken = (String) session.getAttribute("accessToken");
 * if (accessToken != null) { try { spotifyApi.setAccessToken(accessToken);
 * GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
 * .getInformationAboutUsersCurrentPlayback().build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
 * playbackFuture.join(); // 현재 재생 중인 기기 가져오기 Device currentDevice =
 * playbackContext.getDevice(); model.addAttribute("currentDevice",
 * currentDevice); session.setAttribute("currentDevice", currentDevice); // 추가:
 * 모든 연결된 기기 가져오기 GetUsersAvailableDevicesRequest devicesRequest =
 * spotifyApi.getUsersAvailableDevices().build(); CompletableFuture<Device[]>
 * devicesFuture = devicesRequest.executeAsync(); Device[] devices =
 * devicesFuture.join(); model.addAttribute("devices", Arrays.asList(devices));
 * // 추가: 메서드가 호출되었음을 로깅 System.out.println("getDevices 메서드가 호출되었습니다."); } catch
 * (Exception e) { model.addAttribute("error", "기기 목록을 가져오는 중에 오류가 발생했습니다.");
 * return "/errorPage"; } } else { return "redirect:/login"; } return
 * "/devices"; }
 * 
 * @GetMapping("/setVolume/{volume}") public String setVolume(@PathVariable int
 * volume, HttpSession session) throws ParseException { String accessToken =
 * (String) session.getAttribute("accessToken"); if (accessToken != null) {
 * playbackService.setVolume(accessToken, volume); } return
 * "redirect:/sdkrecommendations"; } private String getAlbumId(String trackId,
 * String accessToken) throws ParseException { try { SpotifyApi spotifyApi = new
 * SpotifyApi.Builder().setAccessToken(accessToken).build(); GetTrackRequest
 * getTrackRequest = spotifyApi.getTrack(trackId).build(); Track track =
 * getTrackRequest.execute(); if (track != null) { AlbumSimplified album =
 * track.getAlbum(); if (album != null) { return album.getId(); } } return
 * "default-album-id"; } catch (IOException | SpotifyWebApiException e) {
 * e.printStackTrace(); return "error-album-id"; } } private String
 * getAlbumCoverImageUrl(String albumId, String accessToken) throws
 * ParseException { try { SpotifyApi spotifyApi = new
 * SpotifyApi.Builder().setAccessToken(accessToken).build(); GetAlbumRequest
 * getAlbumRequest = spotifyApi.getAlbum(albumId).build(); Album album =
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
 * .getInformationAboutUsersCurrentPlayback().build();
 * CompletableFuture<CurrentlyPlayingContext> playbackFuture =
 * playbackRequest.executeAsync(); CurrentlyPlayingContext playbackContext =
 * playbackFuture.join(); // 현재 재생 중인 기기 가져오기 Device currentDevice =
 * playbackContext.getDevice(); model.addAttribute("currentDevice",
 * currentDevice); // 추가: 모든 연결된 기기 가져오기 GetUsersAvailableDevicesRequest
 * devicesRequest = spotifyApi.getUsersAvailableDevices().build();
 * CompletableFuture<Device[]> devicesFuture = devicesRequest.executeAsync();
 * Device[] devices = devicesFuture.join(); model.addAttribute("devices",
 * Arrays.asList(devices)); // 추가: 메서드가 호출되었음을 로깅
 * System.out.println("getCurrentPlayback 메서드가 호출되었습니다."); } catch (Exception e)
 * { model.addAttribute("error", "현재 재생 상태를 가져오는 중에 오류가 발생했습니다."); return
 * "/errorPage"; } } else { return "redirect:/login"; } return
 * "/getCurrentPlayback"; } }
 */