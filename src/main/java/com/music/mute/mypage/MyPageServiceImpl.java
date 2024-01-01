package com.music.mute.mypage;

import java.util.concurrent.CompletableFuture;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.music.mute.login.MemberVO;
import com.music.mute.mapper.MemberMapper;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.detailed.UnauthorizedException;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.requests.data.follow.UnfollowPlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.ChangePlaylistsDetailsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;

@Service
public class MyPageServiceImpl implements MyPageService {
	@Inject
	private MemberMapper memberMapper;
	@Autowired
    private SpotifyApi spotifyApi;
	
	@Override
	public MemberVO mypageNickName(String userid) {
		return memberMapper.getMemberBySpotifyUserId(userid);
	}

	@Override
	public void updateNickname(MemberVO member) {
		memberMapper.updateNickname(member);
	}
	
	 @Override
	    public void deletePlaylist(String accessToken, String playlistId) throws Exception {
	        if (accessToken != null) {
	            try {
	                spotifyApi.setAccessToken(accessToken);
	                // 플레이리스트 언팔로우 API 요청
	                final UnfollowPlaylistRequest unfollowPlaylistRequest = spotifyApi.unfollowPlaylist(playlistId).build();
	                unfollowPlaylistRequest.execute();
	                // 삭제 후, 적절한 응답 반환 (이 경우, void 이므로 반환 없이 작업 완료)
	            } catch (Exception e) {
	                e.printStackTrace();
	                throw new Exception("Error deleting playlist");
	            }
	        } else{
	            throw new UnauthorizedException("User not authenticated");
	        }
	    }
	 
	 @Override
	    public void updatePlaylist(String accessToken, String playlistId, String editPlaylistName) throws Exception {
	        if (accessToken != null) {
	            try {
	                spotifyApi.setAccessToken(accessToken);
	                // Spotify API를 사용하여 플레이리스트의 이름을 변경
	                final ChangePlaylistsDetailsRequest changePlaylistDetailsRequest = spotifyApi
	                        .changePlaylistsDetails(playlistId)
	                        .name(editPlaylistName)
	                        .build();
	                changePlaylistDetailsRequest.execute();
	            } catch (Exception e) {
	                e.printStackTrace();
	                throw new Exception("Error updating playlist");
	            }
	        } else{
	            throw new UnauthorizedException("User not authenticated");
	        }
	    }
	}
