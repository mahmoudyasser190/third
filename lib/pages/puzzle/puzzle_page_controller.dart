import '../../core/services/audio_service.dart';
import 'models/puzzle.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';

enum PuzzlePageState { normal, completed }

class PuzzlePageController extends GetxController {
  final AudioService audioService;

  PuzzlePageController({required this.audioService});

  late final Rx<PuzzlePageState> state;

  late final Puzzle puzzle;

  late final ConfettiController confettiController;

  /// Used for [PuzzleType.clickInSequence]
  late final RxList<int> clickedSequence;

  @override
  void onInit() {
    state = PuzzlePageState.normal.obs;
    puzzle = Puzzle.random();
    confettiController = ConfettiController(duration: 5.seconds);
    clickedSequence = <int>[].obs;
    super.onInit();
  }

  Future<void> playWrongChoiceEffect() async => await audioService.playWrongChoiceEffect();

  Future<void> completePuzzle() async {
    state.value = PuzzlePageState.completed;
    confettiController.play();
    await audioService.playLessonCompletionMusic();
    await Future.delayed(confettiController.duration);
    Get.back();
  }

  void addNumberToClickedSequence(int number) => clickedSequence.add(number);

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}
