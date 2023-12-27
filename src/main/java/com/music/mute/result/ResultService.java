package com.music.mute.result;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.music.mute.api.TrackWithImageUrlVO;

import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.miscellaneous.Device;

@Service
public interface ResultService {
		
    String getResultPage(Model model, HttpSession session, String genre);
	
	Device getCurrentDevice(String accessToken) throws IOException, SpotifyWebApiException, ParseException;
	
	String handleException(Exception e, Model model);
	
	List<TrackWithImageUrlVO> getGenreRecommendationTracks(String accessToken, String genre) throws IOException, SpotifyWebApiException, ParseException;
	
	String getAlbumId(String trackId, String accessToken) throws ParseException;
	
	String getAlbumCoverImageUrl(String albumId, String accessToken) throws ParseException;
	

}
