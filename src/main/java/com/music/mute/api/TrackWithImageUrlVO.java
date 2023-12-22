package com.music.mute.api;

import se.michaelthelin.spotify.model_objects.specification.Track;

public class TrackWithImageUrlVO {
    private String coverImageUrl;
    private String name;
    private String artistName;
    private String albumImageUrl;
    private String uri;

    public TrackWithImageUrlVO(Track track, String coverImageUrl) {
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