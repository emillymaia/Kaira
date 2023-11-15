import Foundation
import AVFoundation

class SoundManager: NSObject {
    static let shared = SoundManager()

    private var backgroundMusicPlayer: AVAudioPlayer?
    private var effectSoundPlayer: AVAudioPlayer?

    private var backgroundVolume: Float = 0.7

    private override init() {}

    func playBackgroundMusic(_ filename: String) {
        if let url = Bundle.main.url(forResource: filename, withExtension: "mp3") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer?.numberOfLoops = -1
                backgroundMusicPlayer?.prepareToPlay()
                backgroundMusicPlayer?.play()
            } catch {
                print("Erro ao reproduzir música de fundo: \(error.localizedDescription)")
            }
        }
    }

    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }

    func playEffectSound(_ filename: String) {
        if let url = Bundle.main.url(forResource: filename, withExtension: "mp3") {
            do {

                backgroundVolume = backgroundMusicPlayer?.volume ?? 0.7
                backgroundMusicPlayer?.setVolume(0.3, fadeDuration: 1)

                effectSoundPlayer = try AVAudioPlayer(contentsOf: url)
                effectSoundPlayer?.numberOfLoops = 1
                effectSoundPlayer?.prepareToPlay()
                effectSoundPlayer?.delegate = self
                effectSoundPlayer?.play()
            } catch {
                print("Erro som: \(error.localizedDescription)")
            }
        }
    }
}

extension SoundManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if player == effectSoundPlayer {
            backgroundMusicPlayer?.volume = backgroundVolume
        }
    }
}
