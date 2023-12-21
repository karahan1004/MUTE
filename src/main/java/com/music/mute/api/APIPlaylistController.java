package com.music.mute.api;

import java.io.IOException;
import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.ArtistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.PlaylistTrack;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.TrackSimplified;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumsTracksRequest;
import se.michaelthelin.spotify.requests.data.playlists.ChangePlaylistsDetailsRequest;
import se.michaelthelin.spotify.requests.data.playlists.CreatePlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistsItemsRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchTracksRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

@Controller
public class APIPlaylistController {

	@Autowired
	private SpotifyApi spotifyApi;

	@GetMapping("/apiTest")
	public String getUserPlaylists(Model model, HttpSession session) {
		// 사용자의 Access Token을 세션에서 가져옴
		String accessToken = (String) session.getAttribute("accessToken");

		if (accessToken != null) {
			try {
				spotifyApi.setAccessToken(accessToken);

				final GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
						.getListOfCurrentUsersPlaylists().build();

				final CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();

				// 실제 코드에서는 결과를 처리해야 합니다.
				PlaylistSimplified[] playlists = playlistsFuture.join().getItems();
				System.out.println(playlists[0]);
				model.addAttribute("playlists", playlists);
			} catch (Exception e) {
				// 예외 처리
				e.printStackTrace();
			}
		} else {
			// Access Token이 없는 경우, 로그인 페이지로 리다이렉트 또는 에러 처리
			return "redirect:/login"; // 예시: 로그인 페이지로 리다이렉트
		}

		return "/apiTest";
	}
	

	public String getPlaylistsItems_Sync(Model m,String playlistId) {
		try {
			final GetPlaylistsItemsRequest getPlaylistsItemsRequest = spotifyApi.getPlaylistsItems(playlistId)
//			    		          .fields("description")
//			    		          .limit(10)
//			    		          .offset(0)
//			    		          .market(CountryCode.SE)
//			    		          .additionalTypes("track,episode")
					.build();
			final Paging<PlaylistTrack> playlistTrackPaging = getPlaylistsItemsRequest.execute();
			System.out.println("Total: " + playlistTrackPaging.getTotal());
			
			if (playlistTrackPaging.getTotal() == 0) {
	            return null;
	        }
			
			System.out.println(
					"Track's first artist: " + ((Track) playlistTrackPaging.getItems()[0].getTrack()).getArtists()[0]);
			System.out.println(
					"Track's first name : " + ((Track) playlistTrackPaging.getItems()[0].getTrack()).getName());
			m.addAttribute("trackTotal", playlistTrackPaging.getTotal());
			PlaylistTrack[] arr=playlistTrackPaging.getItems();
			String trackInfo="";
			String artistInfo="";
			for(PlaylistTrack pt:arr) {
				Track tr=(Track)pt.getTrack();//트랙 정보
				ArtistSimplified[] artists=((Track)pt.getTrack()).getArtists();
				trackInfo+=tr.getName()+"#";
				for(ArtistSimplified as:tr.getArtists()) {
				   artistInfo+=as.getName()+"-";
				}
				//artistInfo+="#";
			}
			
			//playlistTrackPaging.getItems()[0].getTrack().getName()
			m.addAttribute("trackArtist", ((Track) playlistTrackPaging.getItems()[0].getTrack()).getArtists()[0].getName());
			m.addAttribute("trackName", ((Track) playlistTrackPaging.getItems()[0].getTrack()).getName());
			m.addAttribute("trackItems", playlistTrackPaging.getItems());
			m.addAttribute("trackInfo", trackInfo);
			m.addAttribute("artistInfo", artistInfo);
			return ((Track) playlistTrackPaging.getItems()[0].getTrack()).getName();
		} catch (IOException | SpotifyWebApiException | ParseException e) {
			System.out.println("Error: " + e.getMessage());
			return null;
		}
		
	}
	
	
	public Track[] getTrack(String trackname) {
        // Build the request to search for tracks
		//이 부분 수정해야됩니다
        SearchTracksRequest request = spotifyApi.searchTracks(trackname).build();

        try {
            // Execute the request and get the search results
            Track[] tracks = request.execute().getItems();

            if (tracks.length > 0) {
                // Get the ID of the first track in the search results
                String trackId = tracks[0].getId();
                System.out.println("Track ID: " + trackId);
                
            } else {
                System.out.println("No tracks found.");
            }
            return tracks;
        } catch (IOException | SpotifyWebApiException|ParseException e) {
            System.err.println("Error: " + e.getMessage());
            return null;
        } 
       
    }
    

	public void getTrack_Sync(String id) {
	    // 앨범 트랙을 가져오기 위한 요청 작성
	    GetAlbumsTracksRequest request = spotifyApi.getAlbumsTracks(id).limit(10).offset(0).build();

	    try {
	        // 요청 실행 및 앨범 트랙 가져오기
	        Paging<TrackSimplified> trackSimplifiedPaging = request.execute();

	        System.out.println("총 트랙 수: " + trackSimplifiedPaging.getTotal());
	        
	        // 플레이리스트 트랙을 반복하고 트랙 ID 출력
	        for (TrackSimplified playlistTrack : trackSimplifiedPaging.getItems()) {
	            String trackId = playlistTrack.getId();
	            String trackName = playlistTrack.getName();  // 트랙의 이름 로깅
	            System.out.println("트랙 ID: " + trackId + ", 트랙 이름: " + trackName);
	        }
	    } catch (IOException | SpotifyWebApiException | ParseException e) {
	        System.out.println("오류: " + e.getMessage());
	    }
	}

	/* @PostMapping("/addPlaylist") */
	public String addPlaylist(Model model, HttpSession session, @RequestParam String playlistName) {
		String accessToken = (String) session.getAttribute("accessToken");

		if (accessToken != null) {
			try {
				spotifyApi.setAccessToken(accessToken);

				final GetCurrentUsersProfileRequest profileRequest = spotifyApi.getCurrentUsersProfile().build();
				final CompletableFuture<User> privateUserFuture = profileRequest.executeAsync();
				User privateUser = privateUserFuture.join();
				String userId = privateUser.getId();

				final CreatePlaylistRequest createPlaylistRequest = spotifyApi.createPlaylist(userId, playlistName)
						.public_(false).build();

				final CompletableFuture<Playlist> playlistFuture = createPlaylistRequest.executeAsync();
				Playlist newPlaylist = playlistFuture.join();

				model.addAttribute("message", "Playlist added successfully: " + newPlaylist.getName());
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("error", "Error adding playlist");
			}
		} else {
			return "redirect:/login";
		}

		return "redirect:/apiTest";
	}

	@GetMapping("/playlisttracks")
	public String getPlaylisttracks(Model model, HttpSession session, @RequestParam("playlistId") String playlistId) {
		System.out.println(">>>> Playlist ID: " + playlistId);
		String accessToken = (String) session.getAttribute("accessToken");
		String trackName=getPlaylistsItems_Sync(model, playlistId);
		if (accessToken != null) {
			try {
				spotifyApi.setAccessToken(accessToken);
				//이거 두 개 추가
				Playlist clickedPlaylist = getClickedPlaylistInfo(playlistId); // 메서드 이름 및 구현은 적절하게 변경되어야 합니다.

	            // 클릭한 플레이리스트 정보를 Model에 추가
	            model.addAttribute("playlist", clickedPlaylist);
	            
	            

				if(trackName==null) return "redirect:/emptyPage";
				Track[] tracks= getTrack(trackName); 
				final GetAlbumsTracksRequest tracksRequest = spotifyApi.getAlbumsTracks(tracks[0].getAlbum().getId()).limit(10).build();
				
				final CompletableFuture<Paging<TrackSimplified>> tracksFuture = tracksRequest.executeAsync();
				
				tracksFuture.join().getItems();
				

				//model.addAttribute("tracks", tracks);
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("error", "Error fetching playlist tracks");
			}
		} else {
			return "redirect:/login";
		}

		return "/playlisttracks";
	}


	private Playlist getClickedPlaylistInfo(String playlistId) {
		try {
	        // GetPlaylistRequest를 사용하여 특정 플레이리스트의 정보를 가져옴
	        final GetPlaylistRequest getPlaylistRequest = spotifyApi.getPlaylist(playlistId).build();
	        final Playlist clickedPlaylist = getPlaylistRequest.execute();
	        System.out.println("clickedPlaylist: "+clickedPlaylist);
	        System.out.println("playlistname:"+clickedPlaylist.getName());

	        // 가져온 플레이리스트 정보를 반환
	        return clickedPlaylist;
	    } catch (IOException | SpotifyWebApiException | ParseException e) {
	        // 예외 처리
	        e.printStackTrace();
	        return null;
	    }
	}
	
	@PostMapping("/updatePlaylist")
	public String updatePlaylist(Model model, HttpSession session, @RequestParam String playlistId, @RequestParam String editPlaylistName) {
	    String accessToken = (String) session.getAttribute("accessToken");

	    if (accessToken != null) {
	        try {
	            spotifyApi.setAccessToken(accessToken);

	            // Spotify API를 사용하여 플레이리스트의 이름을 변경
	            final ChangePlaylistsDetailsRequest changePlaylistDetailsRequest = spotifyApi
	                    .changePlaylistsDetails(playlistId)
	                    .name(editPlaylistName)
	                    .build();

	            changePlaylistDetailsRequest.execute();

	            // 수정 후, 사용자에게 적절한 메시지를 전달
	            model.addAttribute("message", "Playlist updated successfully");
	        } catch (Exception e) {
	            e.printStackTrace();
	            model.addAttribute("error", "Error updating playlist");
	        }
	    } else {
	        return "redirect:/login";
	    }

	    return "redirect:/apiTest";
	}

}