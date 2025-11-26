SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone="+00:00";

CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    username VARCHAR(255),
    name VARCHAR(255),
    password VARCHAR(255),
    is_upn_member BOOLEAN DEFAULT FALSE NOT NULL,
    profile_picture VARCHAR(255) DEFAULT 'https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    followed_authors VARCHAR(255) DEFAULT '[]',
    role VARCHAR(255) DEFAULT 'user',
    PRIMARY KEY (id)
);

CREATE VIEW admins AS
SELECT id,
    email,
    username,
    name,
    password,
    is_upn_member,
    profile_picture,
    created_at,
    followed_authors,
    role
FROM users
WHERE role = 'USERADMIN' OR role = 'ITADMIN';

CREATE TABLE comments (
    id INT NOT NULL AUTO_INCREMENT,
    author INT,
    content TEXT,
    posttype ENUM('DISCUSSION', 'NEWS', 'PODCAST'),
    postid INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    podcastid INT,
    PRIMARY KEY (id)
);

CREATE TABLE posts (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    content TEXT,
    author INT,
    pictures VARCHAR(255) DEFAULT '[]',
    likes INT DEFAULT 0,
    comments INT DEFAULT 0,
    views INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    category ENUM('DISCUSSION', 'NEWS'),
    PRIMARY KEY (id)
);

CREATE VIEW discussions AS
SELECT id,
    title,
    content,
    author,
    pictures,
    likes,
    comments,
    views,
    created_at,
    category
FROM posts
WHERE category = 'DISCUSSION';

CREATE VIEW news AS
SELECT id,
    title,
    content,
    author,
    pictures,
    likes,
    comments,
    views,
    created_at,
    category
FROM posts
WHERE category = 'NEWS';

CREATE TABLE podcasts (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    author INT,
    thumbnail VARCHAR(255),
    duration INT DEFAULT 0,
    views INT DEFAULT 0,
    likes INT DEFAULT 0,
    comments INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    url TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE settings (
    id INT NOT NULL AUTO_INCREMENT,
    userid INT,
    settings VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO comments (id, author, content, posttype, postid, created_at, podcastid) VALUES
('3','5','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','DISCUSSION','4','2024-03-30 14:59:15.986266+00','\N'),
('4','5','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','DISCUSSION','3','2024-03-30 15:12:05.566933+00','\N'),
('5','5','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','NEWS','1','2024-03-30 15:12:27.805309+00','\N'),
('13','1','Permadi muliadi','NEWS','5','2024-04-16 11:44:46.318704+00','\N'),
('20','1','aasdasdasd','NEWS','3','2024-05-12 04:44:51.787553+00','\N'),
('21','1','lkamsdlkamsdlkmasldkmalskdmalkmsdlkasmdlkamsldkmaslkdmalksdmlakmsdlkasmdlkamsdlkamsldkmalskdmlaksmdlkamsldkamsldkmalskdmalksdmlaksmdl','NEWS','3','2024-05-12 05:15:45.684831+00','\N'),
('22','1','asdasdasdasdasd','NEWS','5','2024-05-12 09:45:53.012658+00','\N'),
('2','4','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PODCAST','2','2024-03-30 14:58:42.654021+00','6'),
('26','1','test comment','PODCAST',NULL,'2024-05-21 13:27:17.778712+00','6'),
('27','1','woiaosidaosidjaoisdjoaisjdoaisdj','PODCAST',NULL,'2024-05-21 14:35:25.376154+00','6'),
('25','1','Sangat bermanfaat!','NEWS','9','2024-05-16 03:53:08.100809+00','\N'),
('28','1','Fendi dimana','PODCAST',NULL,'2024-05-21 14:40:19.027236+00','6'),
('29','1','Lorem ipsum','PODCAST',NULL,'2024-05-21 14:44:52.212857+00','5'),
('30','1','Lorem ipsum','PODCAST',NULL,'2024-05-21 14:45:01.250909+00','5'),
('14','1','alskdmalksmdlaksmdlakmsd','NEWS','5','2024-04-18 00:33:12.12124+00','\N'),
('19','1','akmsldkamsldkmasldkmasd','NEWS','3','2024-05-12 04:39:35.920447+00','\N'),
('11','1','klamsdklasmdlkamsdklas','NEWS','1','2024-04-16 11:43:21.586673+00','\N'),
('10','1','alskdmlaksmdlakmsdlkamsd','NEWS','2','2024-04-16 09:32:48.214047+00','\N'),
('31','6','keren bgt\n','NEWS','5','2024-05-23 04:37:36.002687+00','\N'),
('33','6','ssaa','NEWS','9','2024-05-25 03:04:45.370621+00','\N'),
('34','6','shshshs','PODCAST',NULL,'2024-05-25 03:05:40.302696+00','5'),
('35','6','sttsa','NEWS','9','2024-05-25 03:08:01.809114+00','\N'),
('36','6','ahahah','NEWS','9','2024-05-26 05:12:54.318122+00','\N'),
('37','6','tes\n','NEWS','5','2024-05-26 05:13:32.130728+00','\N'),
('38','6','test','PODCAST',NULL,'2024-05-26 05:13:51.218107+00','5'),
('39','1','tesss','NEWS','8','2024-05-28 11:53:23.094563+00','\N'),
('41','1','test 1 (Contoh)','PODCAST',NULL,'2024-05-28 16:56:25.043343+00','1'),
('42','1','test 1 (Contoh)','PODCAST',NULL,'2024-05-28 17:10:02.845312+00','1'),
('1','4','Contoh Komen baru','NEWS','1','2024-03-30 14:58:21.329765+00','\N'),
('44','1','test 1 (Contoh)','DISCUSSION','2','2024-05-29 00:07:20.334114+00','\N'),
('43','1','test 1 (Contoh)','DISCUSSION','3','2024-05-28 17:10:58.985193+00','\N');

INSERT INTO podcasts (id, title, author, thumbnail, duration, views, likes, comments, created_at, url) VALUES
('2','Review Project UI Design Mobile dari pada Androider','3','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/original-a3c7656c746c207995eba8db27460e1c.png','620','152','24','2','2024-03-30 15:05:37.347651+00','\N'),
('3','String 2 - Persiapan UTS Statistika dan Probabilitas','3','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/maxresdefault%20(1).jpg','780','189','15','4','2024-03-30 15:06:25.969332+00','\N'),
('4','Announcement Hasil Rapat BEM-FIK Mei 2024','2','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/WhatsApp-Image-2023-11-19-at-15.10.36.jpeg','720','362','39','12','2024-05-20 13:58:11.3241+00','\N'),
('5','Campus Tour UPN Veteran Jakarta 2024','1','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/maxresdefault%20(2).jpg','375','1280','236','60','2024-05-21 03:09:28.834682+00','https://firebasestorage.googleapis.com/v0/b/dot-sh.appspot.com/o/PETUALANGAN%20MENGENAL%20PROGRAM%20STUDI%20DI%20UPN%20_VETERAN_%20JAKARTA.mp4?alt=media&token=771e8988-e77a-444b-ab8c-23152ebae837'),
('6','String 3 - Persiapan UAS Interaksi Manusia dan Komputer','2','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/BlogWhat-is-Userflow-in-UX-Design_.jpg','924','367','30','12','2024-05-21 04:51:03.25303+00','\N'),
('1','String 1 - Persiapan UTS Struktur Data dan Algoritma','3','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/maxresdefault.jpg','993','321','104','27','2024-03-30 15:04:41.095671+00','\N');

INSERT INTO posts (id, title, content, author, pictures, likes, comments, views, created_at, category) VALUES
('3','Menyongsong Bulan Suci Ramadan: Bagaimana Kontribusi Mahasiswa Dalam Berbagi Takjil?','Dekatnya bulan Ramadan seringkali diwarnai dengan berbagai aksi kebaikan, salah satunya adalah pembagian takjil gratis. Namun, seberapa besar kontribusi mahasiswa dalam berbagi takjil? Mari kita diskusikan pengalaman dan pandangan Anda tentang peran mahasiswa dalam menyongsong Ramadan dengan berbagi kebahagiaan melalui takjil. Apakah Anda merasa tergerak untuk turut berpartisipasi dalam kegiatan semacam ini? Bagikan cerita Anda atau berikan pandangan tentang pentingnya berbagi dalam semangat Ramadan.','4','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/eJDhv5G09z.jpg", "https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/eJDhv5G09z.jpg"]','41','15','204','2024-03-30 14:56:29+00','DISCUSSION'),
('4','Menggali Potensi Mahasiswa: Apakah Anda Percaya Bahwa Kemampuan Pemrograman Dapat Menjadi Kunci Kemenangan?\r\n','Prestasi tim KSM Android dalam memenangkan perlombaan ICPC mengundang pertanyaan menarik: apakah Anda percaya bahwa kemampuan pemrograman dapat menjadi kunci utama untuk meraih kemenangan dalam berbagai kompetisi? Mari kita bahas bersama! Apakah Anda yakin bahwa kemampuan teknis seperti pemrograman memegang peranan penting dalam kesuksesan akademik dan profesional? Ataukah Anda memiliki pandangan lain? Bagikan pemikiran dan pengalaman Anda dalam diskusi ini.','4','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/5e97c962dd1dc.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/5e97c962dd1dc.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/5e97c962dd1dc.jpg"]','34','9','238','2024-03-30 14:57:51+00','DISCUSSION'),
('7','Peluncuran Program Beasiswa "Mendaki Cerdas" oleh UPN "Veteran" Jakarta','<p>UPN "Veteran" Jakarta dengan bangga meluncurkan Program Beasiswa "Mendaki Cerdas" sebagai bentuk komitmen universitas dalam mendukung akses pendidikan tinggi bagi masyarakat kurang mampu. Program ini bertujuan untuk memberikan kesempatan kepada siswa berprestasi dari latar belakang ekonomi yang terbatas untuk mengejar mimpi pendidikan mereka.</p>\n<p>Program Beasiswa "Mendaki Cerdas" menawarkan bantuan keuangan penuh, termasuk biaya kuliah, biaya hidup, dan bantuan buku bagi siswa yang terpilih. Selain itu, program ini juga menyediakan berbagai program pendukung, seperti bimbingan akademik, pelatihan keterampilan, dan mentoring, untuk membantu siswa meraih kesuksesan akademik dan profesional.</p>\n<p>UPN "Veteran" Jakarta mengundang para siswa berprestasi yang berasal dari keluarga kurang mampu untuk mendaftar dan mengikuti proses seleksi Program Beasiswa "Mendaki Cerdas". Universitas ini berharap bahwa program ini dapat memberikan kontribusi yang signifikan dalam meningkatkan akses pendidikan tinggi bagi generasi muda Indonesia.</p>\n<p>Dengan diluncurkannya Program Beasiswa "Mendaki Cerdas", UPN "Veteran" Jakarta berkomitmen untuk terus menjadi agen perubahan positif dalam membantu mewujudkan impian pendidikan setiap individu, tanpa memandang latar belakang ekonomi.</p>\n','1','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/mahasiswa-upn-veteran-jakarta-meminta-penjelasan-rektorat-fo-bcn5.jpg"]','33','16','410','2024-05-10 01:31:01.777296+00','NEWS'),
('1','Gebyar Ramadan : Takjil Gratis kepada mahasiswa Fakultas Ilmu Komputer UPNVJ','UPN Veteran Jakarta menggelar acara Gebyar Ramadan dengan menyediakan takjil gratis bagi mahasiswa Fakultas Ilmu Komputer. Acara yang bertujuan untuk mempererat silaturahim di bulan suci Ramadan ini dihadiri oleh ratusan mahasiswa yang antusias menyambut berkah bulan suci. Takjil gratis yang disediakan tidak hanya menjadi sajian lezat bagi mahasiswa, tetapi juga menjadi momen untuk berbagi kebahagiaan dan kebersamaan di tengah kesibukan akademik. Dengan adanya acara Gebyar Ramadan ini, diharapkan dapat meningkatkan kebersamaan dan kepedulian antar-mahasiswa serta memperkuat ikatan kekeluargaan di lingkungan Fakultas Ilmu Komputer UPNVJ.','3','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/upn-veteran-jakarta-gandeng-asosiasi-pengusaha-hutan-indonesia-K1uFsneCAx.jpeg"]','40','3','86','2024-03-30 14:52:30.214755+00','NEWS'),
('5','Memperluas Horison: Bagaimana Kolaborasi Antar Fakultas Dapat Mendorong Prestasi Akademik?','Prestasi tim debat UPNVJ dalam kompetisi nasional menyoroti pentingnya kolaborasi antar fakultas dalam mencapai keunggulan akademik. Bagaimana pandangan Anda tentang pentingnya kolaborasi lintas fakultas dalam mengembangkan potensi mahasiswa? Apakah Anda berpikir bahwa kerjasama antarbidang studi dapat menghasilkan ide-ide inovatif dan prestasi akademik yang lebih baik? Mari kita eksplorasi bersama bagaimana kerjasama antar fakultas dapat menjadi kunci untuk mencapai keunggulan di tingkat universitas. Bagikan pandangan dan pengalaman Anda dalam diskusi ini.\n','4','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/DSC_1174.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/DSC_1174.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/DSC_1174.jpg","https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/DSC_1174.jpg"]','146','28','353','2024-03-30 15:08:07.260712+00','DISCUSSION'),
('2','KSM Android memenangkan perlombaan ICPC','Keberhasilan gemilang diraih oleh tim KSM Android dari UPN Veteran Jakarta yang berhasil memenangkan perlombaan International Collegiate Programming Contest (ICPC). Dengan kemampuan pemrograman yang luar biasa, tim KSM Android berhasil menyelesaikan serangkaian tantangan pemrograman yang kompleks dan berhasil menjadi yang terbaik di antara ratusan tim peserta dari berbagai negara. Kemenangan ini tidak hanya menjadi kebanggaan bagi UPNVJ tetapi juga membuktikan bahwa mahasiswa-mahasiswa di universitas tersebut memiliki potensi dan kemampuan yang mumpuni dalam bidang teknologi informasi. Diharapkan prestasi ini akan menjadi inspirasi bagi mahasiswa-mahasiswa lainnya untuk terus berprestasi dan mengharumkan nama baik universitas.','3','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/DSC_1253%20(2).jpg"]','40','11','317','2024-03-30 14:56:42.848474+00','NEWS'),
('9','Workshop Kewirausahaan dan Inovasi di UPN "Veteran" Jakarta 2024','<p>UPN "Veteran" Jakarta mengadakan Workshop Kewirausahaan dan Inovasi sebagai bagian dari upaya universitas dalam membantu mahasiswa mengembangkan keterampilan kewirausahaan dan membangun jiwa inovasi. Workshop ini dirancang untuk memberikan pengetahuan dan wawasan praktis tentang proses memulai dan menjalankan bisnis yang sukses.</p>\n<p>Workshop ini menghadirkan para pembicara terkemuka dari berbagai industri yang berbagi pengalaman dan tips praktis tentang kewirausahaan, inovasi, dan pengembangan bisnis. Para peserta workshop diajak untuk terlibat dalam sesi diskusi, studi kasus, dan permainan peran yang dirancang untuk meningkatkan pemahaman dan keterampilan mereka dalam kewirausahaan.</p>\n<p>UPN "Veteran" Jakarta berharap bahwa workshop ini dapat menjadi platform yang bermanfaat bagi mahasiswa untuk mengembangkan potensi kewirausahaan mereka, memperluas jaringan profesional, dan menciptakan solusi inovatif yang dapat memberikan dampak positif bagi masyarakat.</p>\n<p>Dengan meningkatkan kesadaran dan keterampilan kewirausahaan di kalangan mahasiswa, UPN "Veteran" Jakarta percaya bahwa mereka dapat menjadi agen perubahan yang positif dalam menciptakan lapangan kerja, mendorong pertumbuhan ekonomi, dan membangun masa depan yang lebih baik bagi bangsa dan negara. Sekian terimakasih.</p>','1','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/fisip-upn-veteran-jakarta-gelar-seminar-internasional-1_169.jpeg"]','40','23','330','2024-05-10 01:34:10.239207+00','NEWS'),
('6','Seminar Internasional tentang Pembangunan Berkelanjutan di UPN "Veteran" Jakarta','<p>UPN "Veteran" Jakarta menyelenggarakan Seminar Internasional tentang Pembangunan Berkelanjutan sebagai bagian dari upaya universitas dalam memperluas wawasan akademik dan berkontribusi pada pembangunan berkelanjutan di Indonesia. Seminar ini dihadiri oleh para akademisi, praktisi, dan mahasiswa dari berbagai negara untuk berbagi pengetahuan, pengalaman, dan ide-ide inovatif dalam pembangunan berkelanjutan.</p>\n<p>Seminar ini menghadirkan berbagai topik menarik, mulai dari pengelolaan lingkungan, energi terbarukan, hingga pengembangan masyarakat yang berkelanjutan. Para pembicara terkemuka dari dalam dan luar negeri memberikan paparan tentang tren terkini, tantangan, dan solusi dalam pembangunan berkelanjutan.</p>\n<p>Selain itu, dalam seminar ini juga dilakukan diskusi panel yang melibatkan peserta untuk berbagi pandangan dan pemikiran mereka tentang isu-isu penting dalam pembangunan berkelanjutan. Diskusi ini memberikan kesempatan bagi semua peserta untuk berkontribusi secara aktif dalam merumuskan solusi yang dapat diimplementasikan di lapangan.</p>\n<p>UPN "Veteran" Jakarta berharap bahwa seminar ini dapat menjadi ajang inspirasi dan kolaborasi bagi semua pihak yang peduli terhadap pembangunan berkelanjutan. Dengan demikian, universitas ini terus berkomitmen untuk menjadi agen perubahan yang positif dalam memajukan pembangunan berkelanjutan di Indonesia.</p>\n<p>Seminar Internasional tentang Pembangunan Berkelanjutan di UPN "Veteran" Jakarta diharapkan dapat memberikan kontribusi nyata dalam upaya mewujudkan masa depan yang lebih baik bagi generasi mendatang.</p>','3','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/DSC_47421.jpg"]','27','12','229','2024-05-10 01:23:23.560708+00','NEWS'),
('8','Penghargaan Prestasi Akademik Tertinggi bagi Mahasiswa UPN "Veteran" Jakarta','<p>UPN "Veteran" Jakarta merayakan keberhasilan prestasi akademik tertinggi dari sejumlah mahasiswa yang telah menunjukkan dedikasi dan kerja kerasnya dalam mengejar keunggulan akademik. Penghargaan ini diberikan kepada mahasiswa yang berhasil meraih prestasi gemilang dalam studi mereka di berbagai bidang.</p>\n<p>Penghargaan ini meliputi berbagai kategori, termasuk prestasi akademik terbaik, penelitian terbaik, karya tulis ilmiah terbaik, dan proyek-proyek inovatif lainnya yang memberikan kontribusi positif bagi masyarakat dan lingkungan.</p>\n<p>Para penerima penghargaan ini tidak hanya diakui atas keunggulan akademik mereka, tetapi juga atas dedikasi mereka dalam melayani dan memberikan dampak positif bagi lingkungan sekitar. UPN "Veteran" Jakarta bangga memiliki mahasiswa-mahasiswa yang berkomitmen untuk berkontribusi pada pembangunan berkelanjutan dan perubahan sosial yang positif.</p>\n<p>Dengan memberikan penghargaan ini, UPN "Veteran" Jakarta berharap dapat memberikan dorongan motivasi tambahan bagi mahasiswa untuk terus mengejar keunggulan dalam studi mereka dan menginspirasi generasi mendatang untuk mengejar impian mereka.</p>','1','["https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/PKS-dengan-UPN-Veteran-3.jpg"]','46','25','473','2024-05-10 01:32:31.137373+00','NEWS'),
('21','','<p>test</p>','6','[]','0','0','0','2024-05-26 05:13:17.507958+00','DISCUSSION');

INSERT INTO settings (id, userid, settings, created_at) VALUES
('6','10','{}','2024-05-23 04:22:28.835024+00'),
('7','6','{}','2024-05-23 04:36:43.898363+00'),
('3','1','{"postLikes":[4,3,10,15,9,17,18],"podcastLikes":["6"]}','2024-04-17 02:32:47.310976+00'),
('4','2','{"postLikes":["5",9],"podcastLikes":[]}','2024-04-19 06:26:18.864043+00'),
('8','25','{}','2024-05-29 19:24:45.792431+00'),
('5','3','{"postLikes":[]}','2024-05-22 03:20:22.932059+00');

INSERT INTO users (id, email, username, name, password, is_upn_member, profile_picture, created_at, followed_authors, role) VALUES
('2','2310512108@mahasiswa.upnvj.ac.id','2310512108','Vega Setiawan','8e8ac773c4f71f51ae13e6bb80b05b62c06eedfe5bf1569270f69f644bda2cdd','t','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/2-2024419132711-avatar.png','2024-03-30 14:38:50.424619+00','[]','ITADMIN'),
('1','2310512113@mahasiswa.upnvj.ac.id','2310512113','Ashja Radithya Lesmana','ca14e77dc4468941e8b8e1a9960a54444815ae6d25d605145119eb22882e3522','t','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-03-30 14:36:01+00','[]','ITADMIN'),
('5','kitun330@gmail.com','kitun','Kitun Sincaka','3ab1dfe18f030f2998d3cfd7d2bc7e5768b7fac815010e78edb5e82285c011c1','f','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-03-30 14:48:51.622928+00','[]','USER'),
('4','suko002@gmail.com','2210512104','Suko Permadi','d793c5cb41bf56b6dd9a1a9e9e3b034f011594db76139b1fbc164743511fd03e','t','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-03-30 14:46:05.196412+00','[]','USER'),
('18','contoh123@gmail.com','contoh123','contohAsli','123','f','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-05-29 04:01:18.593348+00','[]','USER'),
('20','user@example.com','username','User Name','securepassword','f','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-05-29 06:01:18.522245+00','[]','user'),
('6','2310512119@mahasiswa.upnvj.ac.id','2310512119','Caleb Anthony Evan','47cab2786ba6c0573ba3e50d1d21cbce6c44e38912e39f31d601646095cee493','t','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-05-22 02:59:28.265724+00','[]','USERADMIN'),
('10','2310512102@mahasiswa.upnvj.ac.id','2310512102','Zahir Fakhri Achmad','3cdad5eda0be99fbbbfdabea12538aafdfaacd1c8b7fee4beced3ddfbd623525','t','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-05-22 03:01:26.122267+00','[]','USERADMIN'),
('3','2310512093@mahasiswa.upnvj.ac.id','2310512093','Fendi Permadi','3ce49067c0983cf32682a304a0585d617f2fef5a132d9d63a8b2320ae93ec4f3','t','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-03-30 14:44:51.014422+00','[]','USERADMIN'),
('11','zatinniqotaini@upnvj.ac.id','zatinniqotaini','Zatin Niqotaini','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','t','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-05-23 04:21:44.406904+00','[]','USERADMIN'),
('23','user2@example.com','user2name','User Name','securepassword','f','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-05-29 06:13:40.411164+00','[]','user'),
('24','jamal@upni.com','Jamal123','Jamalludin','fa73338e4a7d529ad8ed3da7d4a6282a73da775117ed4b52d294a580a0d57964','f','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/1-2024526103650-avatar.png','2024-05-29 06:20:52.892545+00','[]','user'),
('25','','',NULL,'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','f','https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z','2024-05-29 19:24:31.992748+00','[]','USER');

-- Query Complex
-- 1.
SELECT p.author, p.title, p.likes
FROM (
    SELECT 
        author,
        title,
        likes,
        ROW_NUMBER() OVER (PARTITION BY author ORDER BY likes DESC) as rn
    FROM posts
) p
WHERE p.rn = 1;

-- 2.
SELECT
    author,
    COUNT(*) AS post_count
FROM posts
GROUP BY author
HAVING COUNT(*) > 2;

-- 3.
SELECT p.title, p.author, p.comments
FROM (
    SELECT 
        title,
        author,
        comments,
        category,
        ROW_NUMBER() OVER (PARTITION BY author ORDER BY comments DESC) as rn
    FROM posts
) p
WHERE p.rn = 1 AND p.category = 'NEWS';

-- 4.
SELECT comment.author, count(comment.content)
FROM comments comment
JOIN users ON comment.author = users.id
GROUP BY comment.author;

-- 5.
SELECT p.title, p.author, COUNT(c.id) AS comment_count
FROM posts p
LEFT JOIN comments c ON p.id = c.postid
WHERE p.category = 'NEWS'
GROUP BY p.id;

-- 6.
SELECT
    p.title,
    p.author,
    p.likes
FROM posts p
WHERE p.likes > (SELECT AVG(likes) FROM posts);

-- 7.
SELECT
    p.title,
    p.author,
    p.category,
    p.created_at
FROM (
    SELECT 
        title,
        author,
        created_at,
        category,
        ROW_NUMBER() OVER (PARTITION BY author ORDER BY created_at DESC) as rn
    FROM posts
) p
WHERE p.rn = 1;

-- 8.
SELECT 
    u.username,
    u.email
FROM users u
LEFT JOIN posts p ON u.id = p.author
WHERE p.id IS NULL
AND u.id IN (SELECT DISTINCT author FROM comments);

-- 9.
SELECT
    p.title,
    p.views,
    u.name
FROM posts p
JOIN users u ON p.author = u.id
WHERE p.views > 300;

-- 10.
WITH user_post_stats AS (
    SELECT
        u.id AS user_id,
        u.username,
        COUNT(p.id) AS total_posts,
        COALESCE(SUM(p.likes), 0) AS total_post_likes,
        COALESCE(SUM(p.comments), 0) AS total_post_comments,
        COALESCE(SUM(p.views), 0) AS total_post_views
    FROM users u
    LEFT JOIN posts p ON u.id = p.author
    GROUP BY u.id
),
user_podcast_stats AS (
    SELECT
        u.id AS user_id,
        COUNT(pc.id) AS total_podcasts,
        COALESCE(SUM(pc.likes), 0) AS total_podcast_likes,
        COALESCE(SUM(pc.comments), 0) AS total_podcast_comments,
        COALESCE(SUM(pc.views), 0) AS total_podcast_views
    FROM users u
    LEFT JOIN podcasts pc ON u.id = pc.author
    GROUP BY u.id
),
user_engagement_stats AS (
    SELECT
        up.user_id,
        up.username,
        up.total_posts,
        COALESCE(ups.total_podcasts, 0) AS total_podcasts,
        up.total_post_likes + COALESCE(ups.total_podcast_likes, 0) AS total_likes,
        up.total_post_comments + COALESCE(ups.total_podcast_comments, 0) AS total_comments,
        up.total_post_views + COALESCE(ups.total_podcast_views, 0) AS total_views
    FROM user_post_stats up
    LEFT JOIN user_podcast_stats ups ON up.user_id = ups.user_id
)
SELECT
    ue.username,
    ue.total_posts,
    ue.total_podcasts,
    ue.total_likes,
    ue.total_comments,
    ue.total_views
FROM user_engagement_stats ue
ORDER BY ue.total_views DESC, ue.total_likes DESC, ue.total_comments DESC;

-- Trigger
DELIMITER //

CREATE TRIGGER trg_update_comment_type
BEFORE UPDATE ON comments
FOR EACH ROW
BEGIN
    IF NEW.postid IS NOT NULL AND OLD.postid IS NULL THEN
        SET NEW.podcastid = NULL;
        SET NEW.posttype = 'DISCUSSION';
    END IF;

    IF NEW.podcastid IS NOT NULL AND OLD.podcastid IS NULL THEN
        SET NEW.postid = NULL;
        SET NEW.posttype = 'PODCAST';
    END IF;
END; //

DELIMITER ;

UPDATE comments SET postid = 2 WHERE id = 44;

-- Procedure 1
DELIMITER //

CREATE PROCEDURE create_user_with_post_and_comment(
    IN p_email VARCHAR(255),
    IN p_username VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_post_title VARCHAR(255),
    IN p_post_content TEXT,
    IN p_comment_content TEXT
)
BEGIN
    DECLARE v_user_id BIGINT;
    DECLARE v_post_id BIGINT;

    INSERT INTO users (email, username, name, password)
    VALUES (p_email, p_username, p_name, p_password);
    SET v_user_id = LAST_INSERT_ID();

    INSERT INTO posts (title, content, author)
    VALUES (p_post_title, p_post_content, v_user_id);
    SET v_post_id = LAST_INSERT_ID();

    INSERT INTO comments (author, content, posttype, postid)
    VALUES (v_user_id, p_comment_content, 'DISCUSSION', v_post_id);
END; //

DELIMITER ;

CALL create_user_with_post_and_comment(
    'user@example.com',
    'username',
    'User Name',
    'securepassword',
    'Post Title',
    'This is the content of the post.',
    'This is a comment on the post.'
);

-- Procedure 2
DELIMITER //

CREATE PROCEDURE create_user_with_posts_and_comments(
    IN p_email VARCHAR(255),
    IN p_username VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_post_titles TEXT,
    IN p_post_contents TEXT,
    IN p_comment_contents TEXT
)
BEGIN
    DECLARE v_user_id BIGINT;
    DECLARE v_post_id BIGINT;
    DECLARE i INT DEFAULT 0;
    DECLARE post_title VARCHAR(255);
    DECLARE post_content TEXT;
    DECLARE comment_content TEXT;
    
    INSERT INTO users (email, username, name, password)
    VALUES (p_email, p_username, p_name, p_password);
    SET v_user_id = LAST_INSERT_ID();

    WHILE i < JSON_LENGTH(p_post_titles) DO
        SET post_title = JSON_UNQUOTE(JSON_EXTRACT(p_post_titles, CONCAT('$[', i, ']')));
        SET post_content = JSON_UNQUOTE(JSON_EXTRACT(p_post_contents, CONCAT('$[', i, ']')));
        SET comment_content = JSON_UNQUOTE(JSON_EXTRACT(p_comment_contents, CONCAT('$[', i, ']')));

        INSERT INTO posts (title, content, author)
        VALUES (post_title, post_content, v_user_id);
        SET v_post_id = LAST_INSERT_ID();

        IF comment_content IS NOT NULL THEN
            INSERT INTO comments (author, content, posttype, postid)
            VALUES (v_user_id, comment_content, 'DISCUSSION', v_post_id);
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No comment provided for post';
        END IF;

        SET i = i + 1;
    END WHILE;
END; //

DELIMITER ;

CALL create_user_with_posts_and_comments(
    'user2@example.com',
    'user2name',
    'User Name',
    'securepassword',
    JSON_ARRAY('Post Title 1', 'Post Title 2'),
    JSON_ARRAY('This is the content of post 1.', 'This is the content of post 2.'),
    JSON_ARRAY('This is a comment on post 1.', 'This is a comment on post 2.')
);


-- Function 1
DELIMITER //

CREATE FUNCTION create_user_post_comment(
    p_email VARCHAR(255),
    p_username VARCHAR(255),
    p_name VARCHAR(255),
    p_password VARCHAR(255),
    p_post_title VARCHAR(255),
    p_post_content TEXT,
    p_comment_content TEXT
) RETURNS JSON
BEGIN
    DECLARE v_user_id BIGINT;
    DECLARE v_post_id BIGINT;
    DECLARE v_comment_id BIGINT;

    INSERT INTO users (email, username, name, password)
    VALUES (p_email, p_username, p_name, p_password);
    SET v_user_id = LAST_INSERT_ID();

    INSERT INTO posts (title, content, author)
    VALUES (p_post_title, p_post_content, v_user_id);
    SET v_post_id = LAST_INSERT_ID();

    INSERT INTO comments (author, content, posttype, postid)
    VALUES (v_user_id, p_comment_content, 'DISCUSSION', v_post_id);
    SET v_comment_id = LAST_INSERT_ID();

    RETURN JSON_OBJECT(
        'user_id', v_user_id,
        'post_id', v_post_id,
        'comment_id', v_comment_id
    );
END; //

DELIMITER ;

SELECT create_user_post_comment(
    'jamal@upni.com',
    'Jamal1123',
    'Jamalludin',
    'fa73388e4a7d529ad8ed3da7d4a6282a73da775117ed4b52d294a580a0d57964',
    'Test post',
    'Test content.',
    'Test Comment.'
);

-- Function 2
DELIMITER //

CREATE FUNCTION get_posts_by_author(author_id BIGINT)
RETURNS TABLE (
    post_id BIGINT,
    title VARCHAR(255),
    content TEXT,
    likes BIGINT,
    comments BIGINT,
    created_at TIMESTAMP,
    category VARCHAR(255)
)
BEGIN
    RETURN
    SELECT
        p.id AS post_id,
        p.title,
        p.content,
        p.likes,
        p.comments,
        p.created_at,
        p.category
    FROM
        posts p
    WHERE
        p.author = author_id;
END; //

DELIMITER ;

SELECT * FROM get_posts_by_author(1);

-- Cursor 1
DELIMITER //

CREATE PROCEDURE update_user_profile_pictures(new_profile_picture VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_user_id BIGINT;
    DECLARE user_cursor CURSOR FOR
        SELECT id FROM users
        WHERE profile_picture = 'https://cozvwhycpghwqqeuzus.supabase.co/storage/v1/object/public/store/default_avatar.svg?t=2024-03-18T06%3A44%3A56.263Z';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN user_cursor;

    read_loop: LOOP
        FETCH user_cursor INTO v_user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE users
        SET profile_picture = new_profile_picture
        WHERE id = v_user_id;
    END LOOP;

    CLOSE user_cursor;

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'User profile pictures updated successfully.';
END; //

DELIMITER ;

CALL update_user_profile_pictures('https://cozwvhycpghwqquezuxs.supabase.co/storage/v1/object/public/store/1-2024526103650-avatar.png');

-- Cursor 2
DELIMITER //

CREATE FUNCTION print_comments_for_post(post_id BIGINT)
RETURNS VARCHAR(255)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE comment_content VARCHAR(255);
    DECLARE comment_cursor CURSOR FOR
        SELECT content FROM comments WHERE postid = post_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN comment_cursor;

    read_loop: LOOP
        FETCH comment_cursor INTO comment_content;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT comment_content;
    END LOOP;

    CLOSE comment_cursor;
END; //

DELIMITER ;

SELECT print_comments_for_post(2);
