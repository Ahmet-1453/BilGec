import '../models/question_model.dart';

final List<QuestionModel> readyQuestions = [
  // TARİH
  QuestionModel(categoryId: 'tarih', questionText: 'İstanbul kaç yılında fethedildi?', options: ['1071', '1299', '1453', '1923'], correctIndex: 2, explanation: '1453 yılında Fatih Sultan Mehmet tarafından.'),
  QuestionModel(categoryId: 'tarih', questionText: 'Cumhuriyet kaç yılında ilan edildi?', options: ['1920', '1923', '1919', '1938'], correctIndex: 1, explanation: '29 Ekim 1923.'),

  // COĞRAFYA
  QuestionModel(categoryId: 'cografya', questionText: 'Türkiye\'nin başkenti neresidir?', options: ['İstanbul', 'Ankara', 'İzmir', 'Bursa'], correctIndex: 1, explanation: 'Başkentimiz Ankara\'dır.'),

  // BİLİM & TEKNOLOJİ
  QuestionModel(categoryId: 'bilim_teknoloji', questionText: 'Ampulü kim icat etti?', options: ['Tesla', 'Edison', 'Einstein', 'Newton'], correctIndex: 1, explanation: 'Thomas Edison.'),

  // MÜZİK
  QuestionModel(categoryId: 'muzik', questionText: 'Pop Müziğin Kralı kimdir?', options: ['Elvis Presley', 'Michael Jackson', 'Madonna', 'Prince'], correctIndex: 1, explanation: 'Michael Jackson.'),

  // FİLM & SİNEMA
  QuestionModel(categoryId: 'film_sinema', questionText: 'Titanik filminin yönetmeni kimdir?', options: ['Nolan', 'Spielberg', 'James Cameron', 'Tarantino'], correctIndex: 2, explanation: 'James Cameron.'),

  // SPOR
  QuestionModel(categoryId: 'spor', questionText: 'Futbolda bir takım sahada kaç kişidir?', options: ['10', '11', '12', '7'], correctIndex: 1, explanation: '11 kişi.'),

  // EDEBİYAT
  QuestionModel(categoryId: 'edebiyat', questionText: 'Sefiller kitabının yazarı kimdir?', options: ['Victor Hugo', 'Tolstoy', 'Dostoyevski', 'Balzac'], correctIndex: 0, explanation: 'Victor Hugo.'),

  // POP KÜLTÜR
  QuestionModel(categoryId: 'pop_kultur', questionText: 'Instagram hangi şirkete aittir?', options: ['Google', 'Meta', 'Apple', 'Amazon'], correctIndex: 1, explanation: 'Meta (Facebook).'),

  // SANAT
  QuestionModel(categoryId: 'sanat', questionText: 'Mona Lisa tablosu kime aittir?', options: ['Van Gogh', 'Picasso', 'Da Vinci', 'Dali'], correctIndex: 2, explanation: 'Leonardo da Vinci.'),

  // DİĞER
  QuestionModel(categoryId: 'diger', questionText: 'Bir haftada kaç gün vardır?', options: ['5', '6', '7', '8'], correctIndex: 2, explanation: '7 gün.'),
];