
/*
 State is a behavioral design pattern that lets an object alter its behavior when its internal state changes. It appears as if the object changed its class.

 Key Idea:

 Instead of using big `if-else` or `switch` statements to handle state transitions, the pattern:
 - Encapsulates each state into its own class.
 - The `context` delegates the behavior to the current state object.

iOS Example:
 Media player(Play,Pause and Stop states).

 */

// Example Media Player

// Define state protocol
protocol PlayerState {
    func play()
    func pause()
    func stop()
}

// Create concrete states
final class PlayingState: PlayerState {
    func play() {
        print("Already playing.")
    }

    func pause() {
        print("Pausing playback.")
    }

    func stop() {
        print("Stopping playback.")
    }
}

final class PausedState: PlayerState {
    func play() {
        print("Resume playing.")
    }

    func pause() {
        print("Already paused.")
    }

    func stop() {
        print("Stopping playback from pause.")
    }
}

final class StoppedState: PlayerState {
    func play() {
        print("Starting playing.")
    }

    func pause() {
        print("Can't pause, playback not playing.")
    }

    func stop() {
        print("Already stopped.")
    }
}

// The Content(Media Palyer)
final class MediaPlayer {
    private var state: PlayerState

    init(state: PlayerState) {
        self.state = state
    }

    func setState(_ state: PlayerState) {
        self.state = state
    }

    func play() {
        state.play()
    }

    func pause() {
        state.pause()
    }

    func stop() {
        state.stop()
    }
}

// Usage

var state = StoppedState()
let player = MediaPlayer(state: state)

// Initially stopped
player.play()
player.setState(PlayingState())

player.play() // Already playing.
player.pause() // Pausing playback.

player.setState(PausedState())
player.stop() // Stopping playback from pause.

player.setState(StoppedState())


/*
 Benefits:

 - Cleaner code by avoiding big switch/if-else blocks.
 - Open/Close principle: Add new states without touching existing logic.
 - Encapsulates state-specific behavior.

 Real world scenarios:

 - URLSessionTask: tasks have states like `.running`, `.suspended` and `.completed`.
 - UIViewController Lifecycle: Handle event differently like `viewWillAppear`, `viewDidLoad`.
 - UIControl state: The button behaves differently in `.normal`, `.highlighted` and `.disabled`.
 */
