import '../models/emotion.dart';
import '../theme/check_in_colors.dart';

/// Bundled emotions by quadrant. Single source of truth for the check-in flow.
/// In the React app these are fetched from API; here we use a representative set.
List<Emotion> getAllEmotions() {
  return [
    ...highEnergyUnpleasantEmotions,
    ...lowEnergyUnpleasantEmotions,
    ...highEnergyPleasantEmotions,
    ...lowEnergyPleasantEmotions,
  ];
}

List<Emotion> getEmotionsByType(String type) {
  return getAllEmotions().where((e) => e.type == type).toList();
}

const List<Emotion> highEnergyUnpleasantEmotions = [
  Emotion(
      id: 'heu-1',
      title: 'Angry',
      description: 'Strong displeasure or hostility',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-2',
      title: 'Anxious',
      description: 'Worry or unease about something',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-3',
      title: 'Stressed',
      description: 'Mental or emotional strain',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-4',
      title: 'Frustrated',
      description: 'Feeling blocked or thwarted',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-5',
      title: 'Nervous',
      description: 'Easily agitated or worried',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-6',
      title: 'Overwhelmed',
      description: 'Too much to cope with',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-7',
      title: 'Tense',
      description: 'Unable to relax',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-8',
      title: 'Irritated',
      description: 'Slightly angry or annoyed',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-9',
      title: 'Panicked',
      description: 'Sudden overwhelming fear',
      type: CheckInColors.highEnergyUnpleasant),
  Emotion(
      id: 'heu-10',
      title: 'Restless',
      description: 'Unable to rest or relax',
      type: CheckInColors.highEnergyUnpleasant),
];

const List<Emotion> lowEnergyUnpleasantEmotions = [
  Emotion(
      id: 'leu-1',
      title: 'Sad',
      description: 'Feeling sorrow or unhappiness',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-2',
      title: 'Lonely',
      description: 'Sad from being alone',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-3',
      title: 'Tired',
      description: 'In need of rest or sleep',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-4',
      title: 'Bored',
      description: 'Lack of interest or stimulation',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-5',
      title: 'Depressed',
      description: 'Low mood and withdrawal',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-6',
      title: 'Disappointed',
      description: 'Sad something didn\'t work out',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-7',
      title: 'Empty',
      description: 'Lacking meaning or feeling',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-8',
      title: 'Gloomy',
      description: 'Dark or sad mood',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-9',
      title: 'Apathetic',
      description: 'Lack of interest or concern',
      type: CheckInColors.lowEnergyUnpleasant),
  Emotion(
      id: 'leu-10',
      title: 'Melancholic',
      description: 'Pensive or lingering sadness',
      type: CheckInColors.lowEnergyUnpleasant),
];

const List<Emotion> highEnergyPleasantEmotions = [
  Emotion(
      id: 'hep-1',
      title: 'Excited',
      description: 'Eager and enthusiastic',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-2',
      title: 'Happy',
      description: 'Feeling pleasure or contentment',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-3',
      title: 'Joyful',
      description: 'Full of joy and delight',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-4',
      title: 'Enthusiastic',
      description: 'Intense enjoyment or interest',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-5',
      title: 'Energetic',
      description: 'Full of energy and drive',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-6',
      title: 'Optimistic',
      description: 'Hopeful about the future',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-7',
      title: 'Inspired',
      description: 'Motivated and creatively stirred',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-8',
      title: 'Playful',
      description: 'Light-hearted and fun',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-9',
      title: 'Proud',
      description: 'Pleased with an achievement',
      type: CheckInColors.highEnergyPleasant),
  Emotion(
      id: 'hep-10',
      title: 'Amused',
      description: 'Entertained or finding something funny',
      type: CheckInColors.highEnergyPleasant),
];

const List<Emotion> lowEnergyPleasantEmotions = [
  Emotion(
      id: 'lep-1',
      title: 'Calm',
      description: 'Peaceful and free from agitation',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-2',
      title: 'Content',
      description: 'Satisfied with what one has',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-3',
      title: 'Relaxed',
      description: 'Free from tension or stress',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-4',
      title: 'Peaceful',
      description: 'Quiet and undisturbed',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-5',
      title: 'Grateful',
      description: 'Thankful and appreciative',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-6',
      title: 'Serene',
      description: 'Calm and untroubled',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-7',
      title: 'Comfortable',
      description: 'At ease and relaxed',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-8',
      title: 'Safe',
      description: 'Protected and secure',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-9',
      title: 'Hopeful',
      description: 'Expecting something good',
      type: CheckInColors.lowEnergyPleasant),
  Emotion(
      id: 'lep-10',
      title: 'At ease',
      description: 'Free from worry or stress',
      type: CheckInColors.lowEnergyPleasant),
];
