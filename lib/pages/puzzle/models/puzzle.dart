import 'dart:math';
import '../../../core/models/animal.dart';

import '../../../core/models/lesson.dart';

enum PuzzleType {
  biggestNumber,
  clickInSequence,
  countTheAnimals,
}

class Puzzle {
  PuzzleType type;
  List<int>? numbers;
  List<int>? sequence;
  int? count;
  Animal? animal;

  Puzzle({
    required this.type,
    this.numbers,
    this.count,
    this.sequence,
    this.animal,
  });

  static int _getRandomNumberWithinLessonsCount() {
    final Random random = Random();
    final int randomNumber = (random.nextInt(Lesson.values.length - 1) + 1);
    return randomNumber;
  }

  factory Puzzle.random() {
    final Random random = Random();
    const List<PuzzleType> puzzleTypes = PuzzleType.values;
    const List<Animal> animals = Animal.values;
    final PuzzleType randomType = puzzleTypes[random.nextInt(puzzleTypes.length)];
    final int randomNumber = _getRandomNumberWithinLessonsCount();
    final Animal randomAnimal = animals[random.nextInt(Animal.values.length)];
    final List<int> randomNumbersList = List<int>.generate(3, (index) => _getRandomNumberWithinLessonsCount());
    // Making sure that no numbers are repeated
    while (randomNumbersList.toSet().length < 3) {
      randomNumbersList.clear();
      randomNumbersList.addAll(List<int>.generate(3, (index) => _getRandomNumberWithinLessonsCount()));
    }
    final int randomSequenceCount = _getRandomNumberWithinLessonsCount();
    final int randomStartingIndex = random.nextInt(Lesson.values.length - randomSequenceCount);
    final List<int> allNumbers = List<int>.generate(Lesson.values.length - 1, (index) => index + 1);
    final List<int> randomRange = allNumbers.getRange(randomStartingIndex, randomStartingIndex + randomSequenceCount).toList();
    final List<int> randomNumbersSequence = randomRange..shuffle();
    return Puzzle(
      type: randomType,
      count: randomType == PuzzleType.countTheAnimals ? randomNumber : null,
      animal: randomType == PuzzleType.countTheAnimals ? randomAnimal : null,
      numbers: randomType == PuzzleType.biggestNumber ? randomNumbersList : null,
      sequence: randomType == PuzzleType.clickInSequence ? randomNumbersSequence : null,
    );
  }
}
