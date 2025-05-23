db = db.getSiblingDB("blogDB");

db.posts.insertMany([
  {
    title: "Belajar Bahasa Jepang N5",
    content: "N5 adalah tingkatan aau level pemahaman dalam bahasa Jepang.",
    author: "Faisal",
    tags: ["Bahasa Jepang", "N5"],
    comments: [
      { author: "Aldy", text: "Penjelasan yang bagus!" },
      { author: "Lukman", text: "Arigatou gozaimasu Faisal-sama." }
    ]
  },    
  {
    title: "Penyusunan Bunpou N5 Bahasa Jepang",
    content: "Pola Kalimat adalah hal yang harus diperhatikan ketika kita mempelajari sebuah bahasa.",
    author: "Ai Maesaroh",
    tags: ["Bunpou", "Pola Kalimat", "N5", "Bahasa Jepang"],
    comments: [{ author: "Faisal", text: "ありがとうございます、とても助かります" }]
  }
]);
