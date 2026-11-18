import '../models/rating.dart';
import '../models/target.dart';

const List<Target> targets = [
  Target('Ms. Reyes - Mathematics', 'Teacher'),
  Target('Mr. Santos - Science', 'Teacher'),
  Target('Ms. Cruz - English', 'Teacher'),
  Target('Mr. Dela Cruz - History', 'Teacher'),
  Target('Ms. Garcia - Filipino', 'Teacher'),
  Target('Mr. Lim - Computer Science', 'Teacher'),
  Target('Foundation Day', 'Event'),
  Target('Career Fair', 'Event'),
  Target('Science Fair', 'Event'),
  Target('Intramurals', 'Event'),
];

const List<Rating> sampleRatings = [
  Rating('Ms. Reyes - Mathematics', 5, 'Explains every step clearly.'),
  Rating('Ms. Reyes - Mathematics', 4, 'Good pace, a bit of homework.'),
  Rating('Mr. Santos - Science', 3.5, 'The labs were fun.'),
  Rating('Mr. Santos - Science', 3, ''),
  Rating('Ms. Cruz - English', 5, 'Great feedback on essays.'),
  Rating('Mr. Dela Cruz - History', 4, 'Stories make it easy to remember.'),
  Rating('Ms. Garcia - Filipino', 5, ''),
  Rating('Mr. Lim - Computer Science', 4.5, 'Clear demos in class.'),
  Rating('Foundation Day', 3.5, 'Too crowded.'),
  Rating('Career Fair', 5, 'Met useful contacts.'),
];
