.

# SPIS-Workshop-25 on 9.4 12:30 onwards

## Part 1

### 1.0 TODO Physiological (EEG/HR) / Movement Tools for MED8

### 1.1 AIVA

- Main: https://aiva.ai/
- Release discord: https://discord.com/channels/595651381860368384/596767903215255572
- Tutorial list @ YouTube
  https://www.youtube.com/watch?v=SR-UWkSTmAQ&list=PLv7BOfa4CxsHp4uDdsmZgpdclrwkdMpOe

#### 1.1.1 TODO

- Check Terms and Conditions and create an account
- Generate 3 versions of a compositions on the web interface
- Open the best one in Editor and edit to improve
- Use an influence, repeat to last steps above for another composition
- Identify the Model / Data / Code structure
- Show and tell: including influence and ethics
- Download your work as MIDI (we'll use in 1.3 onwards)

### 1.2 Machine Learning Basics

- Main: https://playground.tensorflow.org/
- Tinker with the defalult example: What are features, learning rate, activation functions?
- Challenge: Can you create a neural network that only uses the first 2 features as input, and linear as the activation function?
  ![1692675074232](https://github.com/SMC-AAU-CPH/AI-Music-Workshop-23/raw/main/image/README/1692675074232.png)
- Exit: Check around tensorflow @ https://www.tensorflow.org/ (Main tool for Magenta)

### 1.3 NSynth + Magenta Family

- Explore https://magenta.tensorflow.org/get-started
- Find NSynth Explorer at the Web Applications: https://magenta.tensorflow.org/demos/web/ , try it out
- Main: https://magenta.tensorflow.org/nsynth
- Check https://magenta.tensorflow.org/nsynth-instrument If you have Ableton Live or Max/MSP, download the plugin, experiment with the grid. If not, try other web apps.

### 1.4 Magenta Studio

- Download Magenta Studio https://magenta.tensorflow.org/studio (If you have Ableton Live, the plugin version, if not the standalone)
- Make sure to experiment with all 5 tools: [Continue](https://magenta.tensorflow.org/studio/standalone#continue), [Groove](https://magenta.tensorflow.org/studio/standalone#groove), [Generate](https://magenta.tensorflow.org/studio/standalone#generate), [Drumify](https://magenta.tensorflow.org/studio/standalone#drumify), and [Interpolate](https://magenta.tensorflow.org/studio/standalone#interpolate). Apply Magenta models to your MIDI file from (1.1).
- Show and tell at 13:30.

### 1.4 DAW Plugins

- Main: https://interactiveaudiolab.github.io/project/audacity.html
- Download special build of audactiy (Mac only ???)
- Try Usage Example - Upmixing and Remixing with Source Separation with your favorite audio file
- Try adding vocals to your AIVA composition. We have to match the pitch, tempo, harmony, or other attributes with effects.

### 1.5 Solo instruments

- Magenta's DDSP: https://magenta.tensorflow.org/ddsp-vst
  - DDSP models by its authors: https://drive.google.com/drive/folders/1o00rBOLPNEZWURCimK_QQWpvR8iWVeK5
- DDSP + TikTok-like morphing: https://mawf.io/
- 🔥 **Neutone**: https://neutone.space/

### 1.6 Large Language Models (LLMs) applied to Music

* Google Music LM: https://google-research.github.io/seanet/musiclm/examples/
* Meta AudioCraft: https://audiocraft.metademolab.com/
  * AudioBox https://ai.meta.com/blog/audiobox-generating-audio-voice-natural-language-prompts/
* A web UI for LLMs https://sonauto.app/ (requires Google log in)

## Part 2 (Ernests & Anders)

### 2.1 Ernests

Suggestion: Time Series -> ARIMA -> BioX data and processing

### 2.2 Anders (1.5 H))

Suggestion: DAFx all-pass, neutune, or differential DSP

## Part 3 (Projects)

### 3.1 Project initiation and work (1h)

We use ./04-MusicalGestures for 

SMC can integrate 🔥 **Neutone**: https://neutone.space/ in their workflow: create a short musical piece. Ensure to use demucs for source seperation and several generative models together. Be *mindful* [about the resources](https://github.com/QosmoInc/neutone_sdk/pull/48) (sampling rate, buffer size, Real-time factor, latency etc): In most cases you'll be able to run max three instances even on a high-end computer.

MED Track: Integrating Sensor Data and Processing ... TBD

### 3.2 Project presentations (15:30)

Critical listening and discussion. The final pieces will be linked here.

#### Gianluca Eila links

Harmonai, Dance Diffusion
https://www.youtube.com/watch?v=KmB8z2CYjZY

Harmonai
https://www.harmonai.org/

Dadabots keynote
https://www.youtube.com/watch?v=70PjXAOmQIs

Moises horta hexorcismos
https://moiseshorta.audio/

Nice exhibition by ai ethics researcher mirabelle jones, open until aug 27
https://facebook.com/events/s/overs%C3%A6ttelse-af-traumer-transl/2253077421542112/
