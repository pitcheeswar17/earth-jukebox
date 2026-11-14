# 🌍 EARTH JUKEBOX // NASA Mission Telemetry & Sonification Console

> **NASA Space Apps Challenge 2026** — *The Earth Information Jukebox*  
> **Mission Grade:** Flight-Deck Hardware & Interactive 3D WebGL Sonification Console  
> **Datasets:** NASA GISS GISTEMP v4 (1880–2025) &amp; NASA GRACE / GRACE-FO Tellus (2002–2025)

---

## 🛰️ Executive Summary & Concept

**Earth Jukebox** transforms decades of NASA Earth Observation telemetry into an authentic, tactile aerospace mission-control console. It synchronizes a procedural **3D WebGL Earth Globe (Three.js)** with a real-time **Web Audio API synthesizer** and calibrated historical telemetry curves. 

As the mission clock advances from 1880 to 2025:
- **Audio DSP:** Cool baseline periods produce gentle, resonant sine waves panned to the left orbital channel. Accelerated greenhouse warming and polar cryosphere collapse trigger brighter, harmonic sawtooth timbres, rising frequencies, and resonant low-pass filter sweeps panned to the right channel.
- **3D Telemetry Sphere:** The Earth's atmospheric Fresnel rim glow dynamically interpolates from serene cyan (`#38BDF8`) to high-anomaly solar amber (`#F59E0B`) and alert rose (`#EF4444`), while equatorial audio-waveform rings pulse in sync with the real-time sound frequencies.
- **Accessibility:** Full WCAG AAA keyboard-first navigation, throttled screen-reader status announcements, tabular numeric telemetry, and automatic `@media (prefers-reduced-motion)` dampening.

---

## 🕹️ Live Console Access

Open `index.html` directly in any standard browser — zero build tools, zero dependencies, zero CORS errors:

```bash
# Option 1: Direct File Launch
start index.html        # Windows
open index.html         # macOS
xdg-open index.html     # Linux

# Option 2: Local HTTP Server (Already active on port 8080)
# http://localhost:8080
powershell -ExecutionPolicy Bypass -File server.ps1
```

**GitHub Pages Deployment:**
Push this repository to GitHub and enable Pages under `Settings → Pages → Branch: main / (root)`. The pre-configured `.nojekyll` file ensures seamless static hosting.

---

## 📡 NASA Telemetry Datasets (Offline-Ready)

All data is pre-compiled and saved locally in `/data` as standard CSV files and embedded in `data/earth_data.js`:

1. **NASA GISS Surface Temperature Analysis (GISTEMP v4):**
   - **Range:** 1880–2025 (Annual means)
   - **Sectors:** Global (GLB), Northern Hemisphere (NH), Southern Hemisphere (SH)
   - **Metric:** Surface temperature anomalies in °C relative to the 1951–1980 baseline
   - **Citation:** Lenssen, N. et al. (2019), *J. Geophys. Res. Atmos.*, 124(12), 6307–6326.
   - **Local File:** `data/GLB.Ts+dSST.csv`

2. **NASA GRACE & GRACE-FO Tellus Land Ice Mass Variations:**
   - **Range:** 2002–2025 (Annual gravimetric balance)
   - **Sectors:** Greenland Ice Sheet & Antarctica Ice Sheet
   - **Metric:** Cumulative ice mass change in Gigatonnes (Gt) relative to 2002
   - **Citation:** Watkins, M. M. et al. (2015), *Nature Geoscience*, 8, 439–445; NASA JPL PO.DAAC.
   - **Local Files:** `data/greenland_mass.csv`, `data/antarctica_mass.csv`

---

## 🎵 Mission Sonification Mapping Table

| Telemetry Input | Audio DSP Modulation | Scientific Justification |
|---|---|---|
| **Temperature Anomaly** | Oscillator Pitch (220 Hz – 880 Hz, Logarithmic) | Human pitch perception scales logarithmically; an increase from -0.5°C to +1.5°C spans two full musical octaves (A3 to A5). |
| **Ice Sheet Mass (Gt)** | Low-End Frequency & Resonant Filter (440 Hz down to 110 Hz) | As billions of tons of land ice melt into the oceans, the sound descends into a deep sub-bass vibration with increased low-pass resonance. |
| **Anomaly Sign / Regime** | Oscillator Waveform Timbre | Sub-zero cool anomalies synthesize clean, pure sine waves. Severe warming introduces odd and even harmonics via sawtooth waveforms to represent thermodynamic tension. |
| **Rate of Change (d/dt)** | Note Duration & Staccato Trigger | Rapid interannual warming accelerates tempo, producing urgent staccato pulses. |
| **5-Year Trend** | Delay Feedback & Reverb Spatialization | Strong multi-year warming trends increase feedback delay send levels, symbolizing an expanding atmospheric blanket. |
| **Chronological Epoch** | Stereo Spatial Panning (-0.6 Left to +0.6 Right) | Sound begins panned to the far left in 1880 and smoothly transitions across the stereo soundstage, landing at the far right in 2025. |

---

## 🎛️ Aerospace Cockpit Layout & Features

### 1. Left Column — Soundscape & Orbital Playlist
- **Active Soundscape Card:** Displays active track, telemetry sensor ID, and an audio-reactive **24-bar live equalizer**.
- **Tactile Transport Cluster:** Circular beveled hardware buttons (`Previous`, `Play/Pause`, `Next`, `Loop Toggle`, `Reset`).
- **Orbital Playlist Selector (Keys 1–4):**
  1. *Global Surface Pulse* (GISTEMP v4 — Global)
  2. *Northern Amplification* (GISTEMP v4 — Arctic & Northern Hemisphere)
  3. *Greenland Cryosphere* (NASA GRACE — Greenland Ice Mass)
  4. *Antarctica Ice Sheet* (NASA GRACE — Antarctica Mass)
- **Console Calibration:** Dataset and region selectors, epoch range boundaries, clock warp speed (`0.5x` to `4x`), and synthesizer master volume.

### 2. Center Stage — 3D Earth Globe & Synchronized Historical Timeline
- **Interactive 3D Earth Sphere (Three.js):**
  - High-precision procedural canvas texture with vector continental outlines and 15°/30° lat-lon graticule grids.
  - Atmospheric Fresnel glow shell that dynamically interpolates between cool cyan (`#38BDF8`) and amber/rose (`#F59E0B`/`#EF4444`) alerts.
  - Three inclined satellite orbit rings with an active orbiting satellite beacon model.
  - 4 interactive regional 3D beacon pins: clicking any pin on the globe switches the console directly to that mission dataset.
  - Audio-reactive equatorial ring pulsating in real time with the audio frequency spectrum.
  - Automatic 2D canvas radar fallback if WebGL is unavailable.
- **Synchronized Telemetry SVG Chart:** Positioned directly below the globe, rendering the complete telemetry curve with calibrated grid lines, translucent gradient fill, all individual annual data points (146 points for GISTEMP, 24 for GRACE, permanently visible across the entire timeline with interactive hover tooltips and click-to-seek), and a glowing scanline playhead cursor with an active pulsing halo locked to the master clock.
- **Direct Timeline & Point Scrubbing:** Users can click or drag directly across the SVG telemetry chart, click any individual year's data point circle, or drag the full-width orbit progress scrubber with `tabular-nums` elapsed year readouts (`1880` to `2025`).

### 3. Right Column — Spectrum Analyzer, Telemetry & Narrative
- **Spectrum Analyzer Oscilloscope:** High-speed HTML5 `<canvas>` oscilloscope rendering real-time time-domain audio waveforms.
- **2x2 Environmental Telemetry Grid:** Monospaced, zero-jitter `tabular-nums` readouts for *Anomaly/Mass Delta*, *Synthesizer Frequency*, *Rate of Change*, and *Orbital Sector*.
- **Plain-Language Live Explanation Panel:** Dynamic, human-readable scientific narration translating each year's data point for judges, educators, and students, paired with documented historical event alerts (e.g. *1883 Krakatoa*, *1991 Pinatubo*, *2012 Greenland Melt*, *2016 Super El Niño*, *2024 Record Warmth*).
- **Collapsible Mapping & Citations Drawer:** Complete sonification mapping rules, citations, and data provenance.

---

## ♿ Accessibility (WCAG AAA Compliance)

- **Full Keyboard Operability:**
  - `Space` or `K`: Play / Pause sonification
  - `1`, `2`, `3`, `4`: Instant Orbital Track switching
  - `←` / `→`: Single year step backward / forward
  - `M`: Toggle mute
  - `R`: Reset to mission inception
  - `L`: Toggle loop mode
  - `Tab` / `Shift+Tab`: Full logical DOM tab sequence with high-contrast `:focus-visible` cyan outlines
- **Screen-Reader Compatibility:** Throttled `aria-live="polite"` status announcer communicates year and anomaly telemetry without flooding the speech buffer. All controls feature descriptive `aria-label` and `aria-pressed` states.
- **Zero Jitter Typography:** All numeric telemetry readouts use `JetBrains Mono` with `font-variant-numeric: tabular-nums` to eliminate layout shift during live playback.
- **Reduced Motion Support:** `@media (prefers-reduced-motion: reduce)` automatically suspends 3D globe auto-rotation and dampens rapid canvas pulses while preserving audio and scrubber functionality.

---

## 🤖 Use of AI Tools

In accordance with NASA Space Apps Challenge regulations, the use of AI tools in this project is transparently documented below:

- **AI Tools Used:** Google Antigravity (Gemini 2.5 Pro / Flash).
- **AI Contributions:**
  1. Authoring the modular JavaScript architecture: Web Audio API sound synthesis chain (`OscillatorNode`, `BiquadFilterNode`, `GainNode`, `AnalyserNode`), Three.js procedural Earth texture generation, and SVG timeline synchronization.
  2. Crafting the tactile aerospace cockpit CSS design system (deep orbital navy `#050914`, matte instrument cards `#0B1222`, L-shaped reticle corners, tabular numeric typography).
  3. Formatting and embedding published NASA GISTEMP v4 and NASA GRACE datasets into standalone, zero-CORS JavaScript data structures.
  4. Implementing WCAG AAA accessibility patterns, including throttled live-region announcements and keyboard event mapping.
- **Human Guidance & Verification:**
  1. Concept definition, challenge interpretation, and mission architecture design.
  2. Verification that all embedded temperature anomalies and ice mass values match published NASA GISS and JPL Tellus data tables.
  3. Auditing the anti-AI-slop design aesthetic to ensure a functional, authentic JPL flight-deck feel rather than generic templates.
  4. Testing keyboard navigation, audio signal integrity, and 3D performance across desktop and mobile form factors.

All AI-assisted source code blocks are marked with `// AI-GENERATED` comments in the code.

---

## 📁 Project Structure

```
earth-jukebox/
├── index.html            # Complete single-page mission control application
├── manifest.json         # PWA installation manifest
├── .nojekyll             # Static asset override for GitHub Pages
├── server.ps1            # Lightweight PowerShell static HTTP server
├── data/
│   ├── earth_data.js     # Unified NASA GISTEMP & GRACE telemetry constant
│   ├── GLB.Ts+dSST.csv   # NASA GISTEMP Global surface anomaly CSV
│   ├── greenland_mass.csv# NASA GRACE Greenland ice mass variation CSV
│   ├── antarctica_mass.csv# NASA GRACE Antarctica ice sheet mass CSV
│   └── co2_annual.csv    # NASA / NOAA atmospheric CO2 annual CSV
└── README.md             # Mission documentation, citations, and AI declaration
```

---

## ⏱️ 30-Second Live Demo Script for Judges

> **[0:00–0:06] The Hook:**  
> *"Judges, welcome to Earth Jukebox — an authentic aerospace mission console that turns real NASA Earth science telemetry into an interactive 3D WebGL sphere and synchronized Web Audio soundscape."*

> **[0:06–0:14] The Sonic & 3D Synchronization:**  
> *(Press Spacebar to start Track 1: Global Surface Pulse)*  
> *"We begin in 1880. Notice how the cooler pre-industrial years sound as gentle, pure sine tones in the left audio channel. As we approach 2025, watch the 3D Earth's atmospheric glow shift from calm cyan to alert amber, while the pitch climbs more than two octaves into tense sawtooth frequencies panned to the right channel."*

> **[0:14–0:22] Cryosphere Mass Loss Track Switching:**  
> *(Press `3` or click on the Greenland 3D beacon)*  
> *"Pressing key 3 switches instantly to NASA GRACE satellite gravimetry. Here, we hear over 5,800 Gigatonnes of Greenland ice mass loss sonified into a descending low-frequency resonant rumble, while the real-time spectrum analyzer displays the live acoustic waveform."*

> **[0:22–0:30] Accessibility & Open Science:**  
> *(Press Arrow keys to scrub, tap `M` to mute)*  
> *"With full WCAG AAA keyboard navigation, zero external paid APIs, and zero CORS dependencies, Earth Jukebox makes NASA's planetary data accessible to everyone through sight and sound."*
