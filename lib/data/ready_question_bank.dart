import '../models/question_model.dart';

final List<QuestionModel> readyQuestions = [

  QuestionModel(
    id: "tarih_demo_1",
    categoryId: "tarih",
    questionText: "İstanbul kaç yılında fethedildi?",
    options: ["1453", "1071", "1299", "1923"],
    correctIndex: 0,
    explanation: "İstanbul, 29 Mayıs 1453 tarihinde Fatih Sultan Mehmet tarafından fethedilmiştir.",
  ),


  QuestionModel(
    id: "cografya_demo_1",
    categoryId: "cografya",
    questionText: "Türkiye'nin yüz ölçümü bakımından en büyük bölgesi hangisidir?",
    options: ["İç Anadolu", "Doğu Anadolu", "Karadeniz", "Akdeniz"],
    correctIndex: 1,
    explanation: "Doğu Anadolu Bölgesi, Türkiye'nin yüz ölçümü en büyük coğrafi bölgesidir.",
  ),


  QuestionModel(
    id: "fen_demo_1",
    categoryId: "fen_bilimleri",
    questionText: "Suyun kaldırma kuvvetini kim bulmuştur?",
    options: ["Newton", "Einstein", "Arşimet", "Tesla"],
    correctIndex: 2,
    explanation: "Suyun kaldırma kuvveti, Antik Yunan matematikçi ve fizikçi Arşimet tarafından bulunmuştur.",
  ),


  QuestionModel(
    id: "muzik_demo_1",
    categoryId: "muzik",
    questionText: "İstiklal Marşı'mızın bestecisi kimdir?",
    options: ["Mehmet Akif Ersoy", "Osman Zeki Üngör", "Cemal Reşit Rey", "Zeki Müren"],
    correctIndex: 1,
    explanation: "İstiklal Marşı'nın şiirini Mehmet Akif Ersoy yazmış, bestesini ise Osman Zeki Üngör yapmıştır.",
  ),


  QuestionModel(
    id: "sinema_demo_1",
    categoryId: "film_sinema",
    questionText: "Hababam Sınıfı film serisinde 'Mahmut Hoca' karakterini kim canlandırmıştır?",
    options: ["Kemal Sunal", "Şener Şen", "Münir Özkul", "Halit Akçatepe"],
    correctIndex: 2,
    explanation: "Efsanevi Mahmut Hoca karakterine Münir Özkul hayat vermiştir.",
  ),


  QuestionModel(
    id: "spor_demo_1",
    categoryId: "spor",
    questionText: "Bir futbol maçı normal süresi kaç dakikadır?",
    options: ["45", "90", "100", "60"],
    correctIndex: 1,
    explanation: "Futbol maçları 45'er dakikalık iki devre halinde, toplam 90 dakika oynanır.",
  ),


  QuestionModel(
    id: "edebiyat_demo_1",
    categoryId: "edebiyat",
    questionText: "'Sefiller' romanının yazarı kimdir?",
    options: ["Victor Hugo", "Dostoyevski", "Tolstoy", "Goethe"],
    correctIndex: 0,
    explanation: "Sefiller (Les Misérables), Fransız yazar Victor Hugo'nun en ünlü eseridir.",
  ),


  QuestionModel(
    id: "astronomi_demo_1",
    categoryId: "astronomi",
    questionText: "Güneş sistemindeki en büyük gezegen hangisidir?",
    options: ["Mars", "Dünya", "Jüpiter", "Satürn"],
    correctIndex: 2,
    explanation: "Jüpiter, hem çap hem de kütle bakımından Güneş Sistemi'nin en büyük gezegenidir.",
  ),


  QuestionModel(
    id: "sanat_demo_1",
    categoryId: "sanat_kultur",
    questionText: "Mona Lisa tablosu kime aittir?",
    options: ["Picasso", "Van Gogh", "Leonardo da Vinci", "Michelangelo"],
    correctIndex: 2,
    explanation: "Mona Lisa, İtalyan Rönesans sanatçısı Leonardo da Vinci'nin eseridir.",
  ),


  QuestionModel(
    id: "mitoloji_demo_1",
    categoryId: "mitoloji",
    questionText: "Yunan mitolojisinde 'Tanrıların Kralı' kimdir?",
    options: ["Poseidon", "Hades", "Zeus", "Ares"],
    correctIndex: 2,
    explanation: "Zeus, Yunan mitolojisinde göklerin, şimşeklerin ve gök gürültüsünün tanrısı ve Olympos'un kralıdır.",
  ),
];