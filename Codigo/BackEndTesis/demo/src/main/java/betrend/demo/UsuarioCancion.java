package betrend.demo;
import java.io.Serializable;

public class UsuarioCancion implements Serializable {
    private String nombre;
    private double songDurationMs;
    private double acousticness;
    private double danceability;
    private double energy;
    private double instrumentalness;
    private double liveness;
    private double loudness;
    private double audioMode;
    private double speechiness;
    private double tempo;
    private double audioValence;
    private double timeSignature1;
    private double key1;

    // Constructor predeterminado.
    public UsuarioCancion() throws Exception {
        this("Hi", 0.0, -0.5, 0.7, 0.8, 0.0, 0.2, 0.5, 0.7, 0.1, 0.0, 0.6, -0.05, -0.3);
    }

    // Constructor parametrizado.
    public UsuarioCancion(String no, double sd, double ac, double da, double en, double in, 
                          double li, double lo, double am, double sp, double te, double av,
                          double ts, double k) throws Exception {
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

    public void setSongDurationMs(double sd) {
        songDurationMs = sd;
    }

    public void setAcousticness(double ac) {
        acousticness = ac;
    }

    public void setDanceability(double da) {
        danceability = da;
    }

    public void setEnergy(double en) {
        energy = en;
    }

    public void setInstrumentalness(double in) {
        instrumentalness = in;
    }

    public void setLiveness(double li) {
        liveness = li;
    }

    public void setLoudness(double lo) {
        loudness = lo;
    }

    public void setAudioMode(double am) {
        audioMode = am;
    }

    public void setSpeechiness(double sp) {
        speechiness = sp;
    }

    public void setTempo(double te) {
        tempo = te;
    }

    public void setAudioValence(double av) {
        audioValence = av;
    }

    public void setTimeSignature1(double ts) {
        timeSignature1 = ts;
    }

    public void setKey1(double k) {
        key1 = k;
    }

    // Métodos get:
    public String getNombre() {
        return nombre;
    }

    public double getSongDurationMs() {
        return songDurationMs;
    }

    public double getAcousticness() {
        return acousticness;
    }

    public double getDanceability() {
        return danceability;
    }

    public double getEnergy() {
        return energy;
    }

    public double getInstrumentalness() {
        return instrumentalness;
    }

    public double getLiveness() {
        return liveness;
    }

    public double getLoudness() {
        return loudness;
    }

    public double getAudioMode() {
        return audioMode;
    }

    public double getSpeechiness() {
        return speechiness;
    }

    public double getTempo() {
        return tempo;
    }

    public double getAudioValence() {
        return audioValence;
    }

    public double getTimeSignature1() {
        return timeSignature1;
    }

    public double getKey1() {
        return key1;
    }

    // Método toString:
    @Override
    public String toString() {
        return String.format("[ %s, Duration: %.4f, Acousticness: %.4f, Danceability: %.4f, " +
                           "Energy: %.4f, Instrumentalness: %.4f, Liveness: %.4f, " +
                           "Loudness: %.4f, AudioMode: %.4f, Speechiness: %.4f, " +
                           "Tempo: %.4f, Valence: %.4f, TimeSignature: %.4f, Key: %.4f ]",
                           getNombre(), getSongDurationMs(), getAcousticness(), getDanceability(),
                           getEnergy(), getInstrumentalness(), getLiveness(), getLoudness(),
                           getAudioMode(), getSpeechiness(), getTempo(), getAudioValence(),
                           getTimeSignature1(), getKey1());
    }
}