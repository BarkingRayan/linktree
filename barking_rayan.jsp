<%-- File: web/barking_rayan.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barking Rayan</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700;900&family=Rajdhani:wght@300;400;600;700&display=swap');

        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            min-height: 100vh;
            background: #050005;
            font-family: 'Rajdhani', sans-serif;
            display: flex;
            justify-content: center;
            overflow-x: hidden;
        }

        .cave-bg {
            position: fixed; inset: 0;
            background:
                radial-gradient(ellipse at 50% 0%, #1a0a00 0%, transparent 60%),
                radial-gradient(ellipse at 20% 50%, #0d0005 0%, transparent 50%),
                radial-gradient(ellipse at 80% 50%, #00050d 0%, transparent 50%);
            background-color: #050005;
            z-index: 0;
        }

        .torch-left {
            position: fixed; left:-40px; top:30%;
            width:160px; height:280px;
            background: radial-gradient(ellipse, rgba(255,100,0,0.22) 0%, transparent 70%);
            animation: flicker 2s ease-in-out infinite alternate;
            z-index:1; pointer-events:none;
        }
        .torch-right {
            position: fixed; right:-40px; top:30%;
            width:160px; height:280px;
            background: radial-gradient(ellipse, rgba(255,60,0,0.18) 0%, transparent 70%);
            animation: flicker 2.4s ease-in-out infinite alternate-reverse;
            z-index:1; pointer-events:none;
        }
        @keyframes flicker {
            0%   { opacity:0.7; transform:scale(1); }
            50%  { opacity:1;   transform:scale(1.1); }
            100% { opacity:0.8; transform:scale(0.95); }
        }

        .corner { position:fixed; width:50px; height:50px; z-index:5; opacity:0.5; pointer-events:none; }
        .corner-tl { top:12px; left:12px;  border-top:2px solid #b22222; border-left:2px solid #b22222; }
        .corner-tr { top:12px; right:12px; border-top:2px solid #b22222; border-right:2px solid #b22222; }
        .corner-bl { bottom:12px; left:12px;  border-bottom:2px solid #b22222; border-left:2px solid #b22222; }
        .corner-br { bottom:12px; right:12px; border-bottom:2px solid #b22222; border-right:2px solid #b22222; }

        .ember { position:fixed; border-radius:50%; animation:floatUp linear infinite; opacity:0; pointer-events:none; z-index:2; }
        @keyframes floatUp {
            0%   { transform:translateY(100vh) scale(1); opacity:0; }
            10%  { opacity:1; }
            90%  { opacity:0.6; }
            100% { transform:translateY(-20vh) translateX(var(--drift)) scale(0.3); opacity:0; }
        }

        /* ── CONTAINER ── */
        .container {
            position: relative; z-index: 10;
            width: 100%; max-width: 520px;
            padding: 50px 22px 80px;
            display: flex; flex-direction: column; align-items: center;
        }

        /* ── AVATAR — FIXED ── */
        .avatar-wrap { position:relative; margin-bottom:20px; }

        .avatar-ring {
            width: 120px; height: 120px;
            border-radius: 50%;
            border: 3px solid #b22222;
            overflow: hidden;                /* KEY FIX */
            background: radial-gradient(circle, #1a0000, #000);
            box-shadow:
                0 0 20px rgba(178,34,34,0.8),
                0 0 60px rgba(178,34,34,0.3),
                inset 0 0 20px rgba(0,0,0,0.8);
            animation: pulseRing 3s ease-in-out infinite;
        }
        /* Image fills circle perfectly */
        .avatar-ring img {
            width: 100%;
            height: 100%;
            object-fit: cover;        /* fills circle */
            object-position: center;  /* centers crop */
            display: block;
            border-radius: 50%;
            filter: contrast(1.1) saturate(0.9);
        }

        @keyframes pulseRing {
            0%,100% { box-shadow: 0 0 20px rgba(178,34,34,0.8), 0 0 60px rgba(178,34,34,0.3); }
            50%      { box-shadow: 0 0 30px rgba(255,69,0,1),   0 0 90px rgba(255,69,0,0.5); }
        }

        .swords {
            position:absolute; bottom:-12px; left:50%; transform:translateX(-50%);
            font-size:18px; letter-spacing:4px;
            filter: drop-shadow(0 0 6px #ff4500);
        }

        /* ── NAME ── */
        .artist-name {
            font-family: 'Cinzel', serif;
            font-size: 30px; font-weight: 900;
            color: #fff; text-align: center;
            margin-top: 18px; letter-spacing: 4px; text-transform: uppercase;
            text-shadow: 0 0 10px rgba(255,69,0,0.9), 0 0 30px rgba(255,69,0,0.5);
            animation: nameGlow 3s ease-in-out infinite alternate;
        }
        @keyframes nameGlow {
            0%   { text-shadow: 0 0 10px rgba(255,69,0,0.9), 0 0 30px rgba(255,69,0,0.5); }
            100% { text-shadow: 0 0 20px rgba(255,120,0,1),  0 0 60px rgba(255,69,0,0.8); }
        }

        .tagline {
            font-size: 11px; font-weight: 300; color: #666;
            text-align: center; letter-spacing: 3px;
            margin-top: 8px; text-transform: uppercase;
        }

        .divider {
            width: 180px; height: 1px; margin: 22px auto;
            background: linear-gradient(to right, transparent, #b22222, #ff4500, #b22222, transparent);
            box-shadow: 0 0 8px rgba(255,69,0,0.5);
        }

        /* ── SOCIAL ICONS ── */
        .social-row { display:flex; gap:14px; margin-bottom:28px; }
        .social-icon {
            width:42px; height:42px; border-radius:50%;
            border:1px solid rgba(178,34,34,0.5);
            background: rgba(20,0,0,0.8);
            display:flex; align-items:center; justify-content:center;
            text-decoration:none; font-size:18px; color:#ccc;
            transition: all 0.3s ease;
        }
        .social-icon:hover {
            border-color:#ff4500; color:#ff4500;
            box-shadow: 0 0 20px rgba(255,69,0,0.6);
            transform: translateY(-3px) scale(1.1);
        }

        /* ── LINK CARDS ── */
        .links-wrap { width:100%; display:flex; flex-direction:column; gap:12px; }

        .link-card {
            display:flex; align-items:center;
            text-decoration:none; border-radius:12px; overflow:hidden;
            border:1px solid rgba(178,34,34,0.3);
            background: rgba(10,0,0,0.7);
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0,0,0,0.5);
        }
        .link-card:hover {
            border-color: rgba(255,69,0,0.7);
            box-shadow: 0 0 30px rgba(255,69,0,0.3);
            transform: translateY(-3px) scale(1.01);
            background: rgba(20,5,0,0.9);
        }
        .card-icon-wrap {
            width:74px; height:74px;
            display:flex; align-items:center; justify-content:center;
            font-size:28px; flex-shrink:0;
        }
        .yt-bg { background:linear-gradient(135deg,#1a0000,#2d0000); }
        .ig-bg { background:linear-gradient(135deg,#1a0010,#2d0020); }
        .sp-bg { background:linear-gradient(135deg,#001a05,#002d0a); }
        .ap-bg { background:linear-gradient(135deg,#0a0a1a,#15152d); }
        .sc-bg { background:linear-gradient(135deg,#1a0500,#2d0d00); }

        .card-text { flex:1; padding:0 16px; }
        .card-label { font-size:10px; font-weight:600; letter-spacing:3px; text-transform:uppercase; color:#555; margin-bottom:3px; }
        .card-title { font-family:'Cinzel',serif; font-size:14px; font-weight:700; color:#e0e0e0; letter-spacing:1px; }
        .link-card:hover .card-title { color:#ff6020; }
        .card-arrow { padding-right:16px; font-size:18px; color:#444; transition:all 0.3s; }
        .link-card:hover .card-arrow { color:#ff4500; transform:translateX(4px); }

        /* ── YOUTUBE PLAYLIST EMBED ── */
        .playlist-section {
            width: 100%;
            margin-top: 40px;
        }
        .playlist-title {
            font-family: 'Cinzel', serif;
            font-size: 14px;
            font-weight: 700;
            color: #b22222;
            text-align: center;
            letter-spacing: 3px;
            text-transform: uppercase;
            margin-bottom: 16px;
        }
        .playlist-title::before,
        .playlist-title::after {
            content: ' ⚔ ';
            color: #ff4500;
        }
        .playlist-wrap {
            width: 100%;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid rgba(178,34,34,0.4);
            box-shadow: 0 0 30px rgba(178,34,34,0.2), 0 4px 20px rgba(0,0,0,0.6);
        }
        .playlist-wrap iframe {
            width: 100%;
            height: 320px;
            display: block;
            border: none;
        }

        /* ── FOOTER ── */
        .footer {
            margin-top: 50px; text-align:center;
            font-size:10px; letter-spacing:3px; color:#333; text-transform:uppercase;
        }
        .footer span { color:#b22222; }
    </style>
</head>
<body>

<div class="cave-bg"></div>
<div class="corner corner-tl"></div>
<div class="corner corner-tr"></div>
<div class="corner corner-bl"></div>
<div class="corner corner-br"></div>
<div class="torch-left"></div>
<div class="torch-right"></div>
<div id="embers"></div>

<div class="container">

    <!-- Avatar -->
    <div class="avatar-wrap">
        <div class="avatar-ring">
            <%-- Replace YOUR_PHOTO.jpg with your actual image file name --%>
            <img src="img.jpg" alt="Barking Rayan"
                 onerror="this.style.display='none'; this.parentElement.innerHTML='<div style=\'width:100%;height:100%;border-radius:50%;background:linear-gradient(145deg,#1a0000,#0d0000);display:flex;align-items:center;justify-content:center;font-size:48px;\'>&#9876;</div>'">
        </div>
        <div class="swords">&#9876;&#9876;</div>
    </div>

    <h1 class="artist-name">Barking Rayan</h1>
    <p class="tagline">&#9670; The Warrior Speaks Through Sound &#9670;</p>

    <div class="divider"></div>

    <!-- Social Icons -->
    <div class="social-row">
        <a href="https://www.instagram.com/rayan_on_the_bark" target="_blank" class="social-icon" title="Instagram">&#128247;</a>
        <a href="https://www.youtube.com/@BarkingRayan" target="_blank" class="social-icon" title="YouTube">&#9654;</a>
        <a href="https://open.spotify.com/artist/0JXzG34P6bxMuYnIArhJ9b?si=nfXD8xXGSpaRvPFTH9bqiQ" target="_blank" class="social-icon" title="Spotify">&#127925;</a>
    </div>

    <!-- Link Cards -->
    <div class="links-wrap">

        <a href="https://www.youtube.com/@BarkingRayan" target="_blank" class="link-card">
            <div class="card-icon-wrap yt-bg">&#127910;</div>
            <div class="card-text">
                <div class="card-label">Watch</div>
                <div class="card-title">Barking Rayan on YouTube</div>
            </div>
            <div class="card-arrow">&#8250;</div>
        </a>

        <a href="https://www.instagram.com/rayan_on_the_bark" target="_blank" class="link-card">
            <div class="card-icon-wrap ig-bg">&#128247;</div>
            <div class="card-text">
                <div class="card-label">Follow</div>
                <div class="card-title">Barking Rayan on Instagram</div>
            </div>
            <div class="card-arrow">&#8250;</div>
        </a>

        <a href="https://open.spotify.com/artist/0JXzG34P6bxMuYnIArhJ9b?si=nfXD8xXGSpaRvPFTH9bqiQ" target="_blank" class="link-card">
            <div class="card-icon-wrap sp-bg">&#127925;</div>
            <div class="card-text">
                <div class="card-label">Stream</div>
                <div class="card-title">Barking Rayan on Spotify</div>
            </div>
            <div class="card-arrow">&#8250;</div>
        </a>

        <a href="https://music.apple.com/in/artist/barking-rayan/1621715147" target="_blank" class="link-card">
            <div class="card-icon-wrap ap-bg">&#127911;</div>
            <div class="card-text">
                <div class="card-label">Listen</div>
                <div class="card-title">Barking Rayan on Apple Music</div>
            </div>
            <div class="card-arrow">&#8250;</div>
        </a>

        <a href="https://soundcloud.com/barking-rayan" target="_blank" class="link-card">
            <div class="card-icon-wrap sc-bg">&#9729;</div>
            <div class="card-text">
                <div class="card-label">Discover</div>
                <div class="card-title">Barking Rayan on SoundCloud</div>
            </div>
            <div class="card-arrow">&#8250;</div>
        </a>

    </div>

    <!-- ── YOUTUBE PLAYLIST ── -->
    <div class="playlist-section">
        <div class="playlist-title">CHECKOUT MY LATEST ALBUM</div>
        <div class="playlist-wrap">
            <%--
                Replace YOUR_PLAYLIST_ID with your actual YouTube Playlist ID.
                Example: if your playlist URL is:
                https://www.youtube.com/playlist?list=PLxxxxxxxx
                then YOUR_PLAYLIST_ID = PLxxxxxxxx

                Or for a single video embed replace with:
                https://www.youtube.com/embed/YOUR_VIDEO_ID
            --%>
            <iframe
                src="https://www.youtube.com/embed/videoseries?si=LHT9G0gOyZYku8J0&amp;list=PLLtqwSDPcrXJ4mN0uYaYaqC9q5-SjDrXh" 
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen>
            </iframe>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <span>&#9670;</span> Barking Rayan &copy; 2025 <span>&#9670;</span><br>
        Connect with Barking Rayan
    </div>

</div>

<script>
    // Ember particles
    const ec = document.getElementById('embers');
    const colors = ['#ff4500','#ff6020','#ff2200','#ff8c00','#dc143c'];
    for (let i = 0; i < 30; i++) {
        const e = document.createElement('div');
        const size  = Math.random() * 4 + 1;
        const color = colors[Math.floor(Math.random() * colors.length)];
        const dur   = Math.random() * 8 + 5;
        const delay = Math.random() * 10;
        const drift = (Math.random() - 0.5) * 100;
        e.className = 'ember';
        e.style.cssText = `
            width:${size}px; height:${size}px;
            background:${color};
            left:${Math.random() * 100}%;
            bottom:0;
            box-shadow:0 0 ${size*2}px ${color};
            animation-duration:${dur}s;
            animation-delay:${delay}s;
            --drift:${drift}px;
        `;
        ec.appendChild(e);
    }
</script>
</body>
</html>
