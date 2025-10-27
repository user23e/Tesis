import java.io.*;
import java.util.*;

public class UsuarioCancion implements Serializable {
    private String nombre;
    private int songDurationMs;
    private float acousticness;
    private float danceability;
    private float energy;
    private float instrumentalness;
    private float liveness;
    private float loudness;
    private boolean audioMode;
    private float speechiness;
    private float tempo;
    private float audioValence;
    private boolean timeSignature1;
    private boolean key1;

    // Constructor predeterminado.
    public UsuarioCancion() throws Exception {
        this("Hi", 210349, 0.0101f, 0.484f, 0.748f, 0.000239f, 0.242f, -5.049f, true, 0.0491f, 100.568f, 0.654f, false, false);
    }

    // Constructor parametrizado.
    public UsuarioCancion(String no, int sd, float ac, float da, float en, float in, 
                          float li, float lo, boolean am, float sp, float te, float av,
                          boolean ts, boolean k) throws Exception {
        setNombre(no);
        setSongDurationMs(sd);
        setAcousticness(ac);
        setDanceability(da);
        setEnergy(en);
        setInstrumentalness(in);
        setLiveness(li);
        setLoudness(lo);
        setAudioMode(am);
        setSpeechiness(sp);
        setTempo(te);
        setAudioValence(av);
        setTimeSignature1(ts);
        setKey1(k);
    }

    // Métodos set:
    public void setNombre(String no) throws Exception {
        if (no != null && no.length() > 0) {
            nombre = no;
        } else {
            throw new Exception("Nombre de canción inválido.");
        }
    }

    public void setSongDurationMs(int sd) {
        songDurationMs = sd;
    }

    public void setAcousticness(float ac) {
        acousticness = ac;
    }

    public void setDanceability(float da) {
        danceability = da;
    }

    public void setEnergy(float en) {
        energy = en;
    }

    public void setInstrumentalness(float in) {
        instrumentalness = in;
    }

    public void setLiveness(float li) {
        liveness = li;
    }

    public void setLoudness(float lo) {
        loudness = lo;
    }

    public void setAudioMode(boolean am) {
        audioMode = am;
    }

    public void setSpeechiness(float sp) {
        speechiness = sp;
    }

    public void setTempo(float te) {
        tempo = te;
    }

    public void setAudioValence(float av) {
        audioValence = av;
    }

    public void setTimeSignature1(boolean ts) {
        timeSignature1 = ts;
    }

    public void setKey1(boolean k) {
        key1 = k;
    }

    // Métodos get:
    public String getNombre() {
        return nombre;
    }

    public int getSongDurationMs() {
        return songDurationMs;
    }

    public float getAcousticness() {
        return acousticness;
    }

    public float getDanceability() {
        return danceability;
    }

    public float getEnergy() {
        return energy;
    }

    public float getInstrumentalness() {
        return instrumentalness;
    }

    public float getLiveness() {
        return liveness;
    }

    public float getLoudness() {
        return loudness;
    }

    public boolean getAudioMode() {
        return audioMode;
    }

    public float getSpeechiness() {
        return speechiness;
    }

    public float getTempo() {
        return tempo;
    }

    public float getAudioValence() {
        return audioValence;
    }

    public boolean getTimeSignature1() {
        return timeSignature1;
    }

    public boolean getKey1() {
        return key1;
    }

    // Método toString:
    @Override
    public String toString() {
        return String.format("[ %s, Duration: %d ms, Acousticness: %.4f, Danceability: %.4f, " +
                           "Energy: %.4f, Instrumentalness: %.6f, Liveness: %.4f, " +
                           "Loudness: %.3f dB, AudioMode: %b, Speechiness: %.4f, " +
                           "Tempo: %.3f BPM, Valence: %.4f, TimeSignature: %b, Key: %b ]",
                           getNombre(), getSongDurationMs(), getAcousticness(), getDanceability(),
                           getEnergy(), getInstrumentalness(), getLiveness(), getLoudness(),
                           getAudioMode(), getSpeechiness(), getTempo(), getAudioValence(),
                           getTimeSignature1(), getKey1());
    }
}