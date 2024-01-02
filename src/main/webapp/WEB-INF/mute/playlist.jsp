<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="resources/css/playlist.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

        <!-- jQuery 라이브러리 추가 -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap JS와 Popper.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

        <script src="https://sdk.scdn.co/spotify-player.js"></script>

        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <%@ page import="se.michaelthelin.spotify.model_objects.specification.Track" %>



                    <title>MU:TE</title>
    </head>

    <body>
        <header>
            <table id="navi-head">
                <tr>
                    <td class="head-lg" rowspan="2"><a href="main"><img class="logo"
                                src="resources/images/mutelogo.png"></a></td>
                    <td class="head-na" rowspan="2"><a class="pl">${playlist.name}</a></td>
                    <td class="head-ba"><a href="mypage"><img class="back" src="resources/images/gom_button.png"></a>
                    </td>

                </tr>
                <tr>
                    <td class="head-ba" rowspan="3"><a class="backft" href="mypage">뒤로가기</a></td>
                </tr>
            </table>
        </header>
        <hr>
        <div>
            <table id="menu">
                <tr>
                    <!-- 임시로 곰버튼 이미지 넣어둠 -->
                    <td class="meal">앨범 표지</td>
                    <td class="mesi">노래 제목</td>
                    <td class="mega">가수 이름</td>
                    <td class="medel">삭제</td>
                </tr>
            </table>

        </div>
        <hr>
        <div id="scroll">

            <table id="sing-mi">

                <c:forEach var="track" items="${trackInfoArray}" varStatus="status">
                    <tr>
                        <td class="pi">
                            <c:set var="albumDetailsArray" value="${fn:split(albumInfoArray[status.index], ',')}" />
                            <img class="albumimg" src="${albumDetailsArray[1]}" alt="Album Cover" width="100"
                                height="100">
                        </td>
                        <td class="si" data-track-id="${trackIdList[status.index]}"
                            data-track-uri="${trackUriArray[status.index]}">${track}</td>
                        <td class="ga">${artistInfoArray[status.index]}</td>
                        <td class="del"><a
                                onclick="handleDeleteAction('${playlist.id}', '${trackIdList[status.index]}');">
                                <img class="del_img" src="resources/images/del_pl.png">
                            </a></td>


                    </tr>
                </c:forEach>



            </table>
        </div>

        <footer>
            <table id="navi-foot">
                <tr>
                    <td class="si_btn"><img class="bt_img" src="resources/images/before_pl.png"></td>
                    <td class="si_btn"><img class="playPauseImage" id="ft_img"
                            src="<c:url value='/resources/images/play_pl.png'/>" alt="Play/Pause" width="50"
                            height="50"></td>
                    <td class="si_btn"><img class="at_img" src="resources/images/after_pl.png">
                    </td>
                    <td class="si_btn"><img class="im_foot" src="resources/images/gom_button.png"></td>
                    <td class="si_foot"></td>
                    <td class="ga_foot"></td>
                    <td class="sa_btn" onclick="toggleVolumeSlider()"><img class="so_img"
                            src="resources/images/sound_pl.png"></td>
                    <td class="volume-container"><input type="range" min="0" max="100" value="50" class="volume-slider"
                            id="volumeSlider" onchange="setVolume(this.value)"></td>
                    <td></td>
                </tr>
            </table>
        </footer>

        <!-- ================================================ -->
        <!-- The Modal -->
        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <form name="rf" id="rf">
                        <table id="modaltable">
                            <tr>
                                <td class="del-td text-center"><a class="singdel text-body">이
                                        노래를 삭제 하시겠습니까?</a></td>
                            </tr>
                        </table>
                        <br>
                        <button type="button" class="close-btn" onclick="confirmDelete()">삭제</button>
                        <button type="button" class="close-btn" onclick="toggleModal('addModal')">취소</button>
                        <br> <br>
                    </form>
                </div>
            </div>
        </div>

        <script>
            var originalImgSrc = "resources/images/play_pl.png";
            var altImgSrc = "resources/images/pause_pl.png";
            let trackUri = {};
            function toggleImg() {
                var imgElement = document.getElementById("ft_img");
                if (imgElement.getAttribute("src") === originalImgSrc) {
                    imgElement.src = altImgSrc;

                } else {
                    imgElement.src = originalImgSrc;
                }
            }

            function toggleVolumeSlider() {
                var slider = document.querySelector('.volume-slider');
                slider.style.display = (slider.style.display === 'none' || slider.style.display === '') ? 'block'
                    : 'none';
            }

            function toggleModal(modalId) {
                $('#' + modalId).modal('toggle');
            }

            function scheduleDeleteTrack(playlistId, trackId) {
                console.log('trackId : ' + trackId);
                console.log('playlistId : ' + playlistId);

                if (confirm('정말로 이 트랙을 삭제하시겠습니까?')) {
                    // 확인을 선택한 경우에만 트랙 삭제 함수 호출
                    deleteTrack(playlistId, trackId);
                }
            }

            function handleDeleteAction(playlistId, trackId) {
                // 삭제 전이나 후에 수행할 공통 작업을 추가하세요
                console.log('playlistId:', playlistId);
                console.log('trackId:', trackId);
                $('#addModal').data('playlistId', playlistId);
                $('#addModal').data('trackId', trackId);

                // 삭제 후 모달을 토글하려면 다음과 같이 할 수 있습니다:
                toggleModal('addModal');
            }

            function confirmDelete() {
                // 여기에 실제 삭제 동작을 추가할 수 있음
                // 삭제가 성공하면 모달을 닫도록 처리
                // 예시: 삭제 성공 후 모달을 닫고 싶다면 toggleModal('addModal')을 호출

                // 저장된 playlistId와 trackId 검색
                var playlistId = $('#addModal').data('playlistId');
                var trackId = $('#addModal').data('trackId');
                //alert(trackId);
                // Ajax를 이용하여 서버에 삭제 요청을 보낼 수 있습니다.
                $.ajax({
                    type: 'POST',
                    url: '/mute/deleteTrack',
                    data: `playlistId=\${playlistId}&trackId=\${trackId}`,
                    success: function (response) {
                        // 서버에서 성공적으로 응답을 받으면 모달을 닫습니다.
                        alert("트랙이 삭제 되었습니다."); // 또는 적절한 메시지를 표시
                        toggleModal('addModal');
                    },
                    error: function (error) {
                        // 에러 처리
                        alert('Error deleting track: ' + error.responseText);
                    }
                });
            }


            document.addEventListener('DOMContentLoaded', () => {
                initMusicPlay();
            });

            /* 플레이어 관련 이벤트 초기화 */
            function initMusicPlay() {
                let btnPlayer = document.querySelector('#ft_img');
                let btnPrevious = document.querySelector('.bt_img');
                let btnNext = document.querySelector('.at_img');
                var currentIndex = 0;
                btnPlayer.setAttribute('isPlay_test', '0'); // 0 정지, 1 재생

                /* 재생/정지 클릭 이벤트 */
                btnPlayer.addEventListener("click", function (event) {
                    if (event.target.getAttribute('isPlay_test') === '0') {
                        musicPlay();
                        btnPlayer.setAttribute('isPlay_test', '1'); // 0 정지, 1 재생
                    } else {
                        musicPause();
                        btnPlayer.setAttribute('isPlay_test', '0'); // 0 정지, 1 재생
                    }
                });
                /* 이전 곡 클릭 이벤트 */
                btnPrevious.addEventListener("click", function (event) {
                    console.log('이전 트랙으로 이동');
                    if (currentIndex > 0) {
                        currentIndex--;
                        updatePlayer();
                    }

                    $.ajax({
                        url: SPOTIFY_API_BASE + '/previous',
                        type: 'POST',
                        headers: {
                            'Authorization': 'Bearer ' + accessToken,
                        },
                        success: function () {
                            console.log('이전 트랙으로 이동 성공');
                            //musicPause(); //
                            musicPlay();
                        },
                        error: function (error) {
                            console.error('이전 트랙으로 이동 실패:', error);
                        }
                    });
                });

                /* 다음 곡 클릭 이벤트 */
                btnNext.addEventListener("click", function (event) {
                    console.log('다음 트랙으로 이동');
                    var totalRows = $('.pi').length;
                    if (currentIndex < totalRows - 1) {
                        currentIndex++;
                        updatePlayer();
                    }

                    $.ajax({
                        url: SPOTIFY_API_BASE + '/next',
                        type: 'POST',
                        headers: {
                            'Authorization': 'Bearer ' + accessToken,
                        },
                        success: function () {
                            console.log('다음 트랙으로 이동 성공');
                            //musicPause(); //
                            musicPlay();
                        },
                        error: function (error) {
                            console.error('다음 트랙으로 이동 실패:', error);
                        }
                    });
                });

                updatePlayer();
                /* 음악 목록 클릭 이벤트 */
                $('.pi, .si, .ga').on('click', function () {
                    var albumImageSrc = $(this).closest('tr').find('.pi img').attr('src');
                    var songTitle = $(this).closest('tr').find('.si').text();
                    var artistName = $(this).closest('tr').find('.ga').text();
                    var trackId = $(this).closest('tr').find('.si').attr('data-track-id');
                    var trackUri = $(this).closest('tr').find('.si').attr('data-track-uri');
                    // 선택한 행에 맞게 footer 부분 변경
                    $('#ft_img').attr('data-track-id', trackId);
                    $('#ft_img').attr('data-track-uri', trackUri);
                    $('.im_foot').attr('src', albumImageSrc);
                    $('.si_foot').text(songTitle);
                    $('.ga_foot').text(artistName);

                    currentIndex = $(this).closest('tr').index();
                    updatePlayer();
                    musicPlay(); // 목록 클릭시에도 바로 재생.
                    //changePlayerImage();
                });

                /* 플레이어 정보 업데이트 */
                function updatePlayer() {
                    var albumImageSrc = $('.pi').eq(currentIndex).find('img').attr('src');
                    var songTitle = $('.si').eq(currentIndex).text();
                    var artistName = $('.ga').eq(currentIndex).text();
                    var trackId = $('.si').eq(currentIndex).attr('data-track-id');
                    var trackUri = $('.si').eq(currentIndex).attr('data-track-uri');

                    // footer 부분 변경
                    $('#ft_img').attr('data-track-id', trackId);
                    $('#ft_img').attr('data-track-uri', trackUri);
                    $('.im_foot').attr('src', albumImageSrc);
                    $('.si_foot').text(songTitle);
                    $('.ga_foot').text(artistName);
                }

                /* 플레이어 버튼 이미지 변경 */
                function changePlayerImage(isPlay) {
                    $('.ft_img').attr('src',
                        'resources/images/pause_pl.png');

                    if (isPlay) {
                        btnPlayer.setAttribute('isPlay_test', '1');
                        btnPlayer.setAttribute('src', '/mute/resources/images/pause_pl.png');
                    } else {
                        btnPlayer.setAttribute('isPlay_test', '0');
                        btnPlayer.setAttribute('src', '/mute/resources/images/play_pl.png');
                    }
                }
                /* function musicPlay2(){
                    let n=btnPlayer.getAttribute('isplay_test');
                    var trackUri = btnPlayer.getAttribute('data-track-uri');
                    alert("n="+n)
                    if(n=='1'){
                        player.resume().then(()=>{
                            trackState[trackUri]=true;
                        })
                    }else{
                        player.pause().then(()=>{
                            trackState[trackUri]=false;
                        })
                    }
                } */
                /* 음악 재생 */
                function musicPlay() {
                    var trackId = btnPlayer.getAttribute('data-track-id');
                    var currentTrackUri = btnPlayer.getAttribute('data-track-uri');

                    let pos_ms = 0;
                    if (trackUri == currentTrackUri) {
                        pos_ms = trackPositions[trackUri];
                        //alert("trackPositions%%%%"+trackPositions[trackUri]);

                    }
                    $.ajax({
                        url: SPOTIFY_API_BASE + '/play' + '?device_id=' + device_id,
                        type: 'PUT',
                        async: false,//동기적으로 수행하도
                        headers: {
                            'Authorization': 'Bearer ' + accessToken,
                            'Content-Type': 'application/json',
                        },
                        data: JSON.stringify({
                            uris: ["spotify:track:" + trackId],
                            device_ids: [device_id],
                            position_ms: pos_ms || 0,
                        }),

                        success: function () {
                            changePlayerImage(true);
                        },
                        error: function (error) {
                            console.error('트랙 재생/일시정지 실패:', error);
                            console.error('API 호출 실패 상세 정보:', error.responseText);
                        }
                    });
                }

                /* 음악 정지 */
                function musicPause() {
                    var trackId = btnPlayer.getAttribute('data-track-id');

                    var currentTrackUri = btnPlayer.getAttribute('data-track-uri');
                    let pos_ms = 0;
                    if (trackUri == currentTrackUri) {
                        pos_ms = trackPositions[trackUri];

                    }
                    $.ajax({
                        url: SPOTIFY_API_BASE + '/pause' + '?device_id=' + device_id,
                        type: 'PUT',
                        async: false,
                        headers: {
                            'Authorization': 'Bearer ' + accessToken,
                            'Content-Type': 'application/json',
                        },
                        data: JSON.stringify({
                            uris: ["spotify:track:" + trackId],
                            device_ids: [device_id],
                            position_ms: pos_ms || 0,
                        }),
                        success: function (response) {
                            changePlayerImage(false);
                        },
                        error: function (error) {
                            console.error('API 호출 실패:', error);
                            if (error.status === 401) {
                                console.error('토큰이 만료되었거나 잘못되었습니다. 새로운 토큰을 요청하세요.');
                            } else {
                                console.error('상세 정보:', error.responseText);
                            }
                        }
                    });
                }
            }


            let player;
            let device_id;
            let progress_ms;
            let trackPositions = {};
            let trackIds = {};
            let trackState = {};

            window.onSpotifyWebPlaybackSDKReady = () => {
                const token = '${accessToken}'; // 사용자의 액세스 토큰을 여기에 설정
                player = new Spotify.Player({
                    name: 'Web Playback SDK',
                    getOAuthToken: (cb) => { cb(token); }
                });
                console.dir(player)
                player.connect();

                player.on('player_state_changed', state => {
                    if (state) {
                        console.log('Current track:', state.track_window.current_track);
                        //console.log('Current track Id:', state.track_window.current_track.id);

                        console.log('Current progress (ms):', state.position);
                        trackPositions[state.track_window.current_track.uri] = state.position;
                        trackIds[state.track_window.current_track.uri] = state.track_window.current_track.id;
                        trackState[state.track_window.current_track.uri] = state.paused;//재생 중인지 여부
                        console.log('trackState: ' + trackState[state.track_window.current_track.uri])
                        console.log('trackIds: ' + trackIds[state.track_window.current_track.uri])
                        trackUri = state.track_window.current_track.uri;
                    }
                });

                // Ready
                player.on('ready', data => {
                    console.log('Ready with Device ID', data.device_id);
                    device_id = data.device_id;
                    // Play a track using our new device ID
                    //play(data.device_id);
                });


                player.connect();
                console.log("===연결됨======================================")
            };

            const SPOTIFY_API_BASE = 'https://api.spotify.com/v1/me/player';
            const accessToken = "${accessToken}"; // Java 코드에서 받아온 accessToken
            // 이미지 토글 상태를 나타내는 객체
            var isPlayingMap = {};
            // 이미지 클릭 이벤트에 플레이/일시정지 기능 추가



            function togglePlayPause(trackUri, imageElement) {


                if (!isPlaying) {
                    // 재생을 계속하는 경우 현재 트랙의 진행 상황을 가져옵니다.
                    const currentState = player.getCurrentState();
                    currentState.then(state => {
                        if (state) {
                            console.log('!isPlaying:' + state.position)
                            trackPositions[trackUri] = state.position;
                            trackState[trackUri] = true;
                        }
                    });
                    imageElement.classList.add('playing')

                } else {
                    trackState[trackUri] = false;
                    imageElement.classList.remove('playing')
                }
                //imageElement.classList.toggle('playing');

                // 서버에서 trackId 값을 받아오는 예시
                $.ajax({
                    url: SPOTIFY_API_BASE + (isPlaying ? '/play' : '/pause') + '?device_id=' + device_id,
                    type: 'PUT',
                    headers: {
                        'Authorization': 'Bearer ' + accessToken,
                        'Content-Type': 'application/json',
                    },
                    data: JSON.stringify({
                        uris: [trackUri],
                        device_ids: [device_id],
                        position_ms: trackPositions[trackUri] || 0,
                    }),
                    success: function (response) {
                        // 이 부분에서 응답을 확인하고 trackId를 추출하는 로직을 추가
                        let trackId = trackIds[trackUri];
                        console.log('success1: ' + trackId)
                        togglePlayPauseImage(trackUri, imageElement);
                        if (response && response.trackId) {
                            trackId = response.trackId;
                            console.log('success2: ' + trackId)
                        } else {
                            console.error('trackId를 찾을 수 없습니다. 응답 구조를 확인하세요.');
                            return;
                        }



                    },
                    error: function (error) {
                        console.error('API 호출 실패:', error);
                        if (error.status === 401) {
                            console.error('토큰이 만료되었거나 잘못되었습니다. 새로운 토큰을 요청하세요.');
                        } else {
                            console.error('상세 정보:', error.responseText);
                        }
                    },

                });
            }

            // 이미지 토글 함수
            function togglePlayPauseImage(trackUri, imageElement) {
                // 이미지 토글
                /* if (imageElement.classList.contains('playing')) {
                    imageElement.src = '<c:url value="/resources/images/play_pl.png"/>';
                    console.log("음악 일시정지");
                } else {
                    imageElement.src = '<c:url value="/resources/images/pause_pl.png"/>';
                    console.log("음악 재생");
                }
                //  */
                imageElement.classList.toggle('playing');
            }

            let position_ms = null;

            function playTest(uri) {
                const playlistUri = uri;
                player.resume();

            }

            function setVolume(volume) {
                console.log('볼륨 조절: ' + volume);
                $.ajax({
                    url: SPOTIFY_API_BASE + '/volume?volume_percent=' + volume,
                    type: 'PUT',
                    headers: {
                        'Authorization': 'Bearer ' + accessToken,
                        'Content-Type': 'application/json', // 헤더에 Content-Type 추가
                    },
                    success: function () {
                        console.log('볼륨 조절 성공');
                    },
                    error: function (error) {
                        console.error('볼륨 조절 실패:', error);
                        console.error('API 호출 실패 상세 정보:', error.responseJSON);

                        // 에러 처리: HTTP 404 Not Found일 때
                        if (error.status === 404) {
                            console.error('Spotify 장치를 찾을 수 없음');
                            // 여기에서 다른 작업을 수행하거나 사용자에게 메시지를 표시할 수 있습니다.
                        }
                    },
                });
                // UI에 현재 볼륨 표시
                $('#volumeLabel').text(volume);
            }

        </script>



    </body>

    </html>