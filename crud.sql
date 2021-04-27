-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Apr 2021 pada 18.53
-- Versi server: 10.4.18-MariaDB
-- Versi PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crud`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `cuti`
--

CREATE TABLE `cuti` (
  `id_cuti` int(5) NOT NULL,
  `no_induk` varchar(10) NOT NULL,
  `tanggal_cuti` date NOT NULL,
  `lama_cuti` int(5) NOT NULL,
  `ket` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `cuti`
--

INSERT INTO `cuti` (`id_cuti`, `no_induk`, `tanggal_cuti`, `lama_cuti`, `ket`) VALUES
(7, 'IP06001', '2020-08-02', 2, 'Acara Keluarga'),
(8, 'IP06001', '2020-08-18', 2, 'Anak Sakit'),
(9, 'IP06006', '2020-08-19', 1, 'Nenek Sakit'),
(10, 'IP06007', '2020-08-23', 1, 'Sakit'),
(11, 'IP06004', '2020-08-29', 5, 'Menikah'),
(12, 'IP06003', '2020-08-30', 2, 'Acara Keluarga');

-- --------------------------------------------------------

--
-- Struktur dari tabel `karyawan`
--

CREATE TABLE `karyawan` (
  `id` int(5) NOT NULL,
  `no_induk` varchar(10) NOT NULL,
  `nama` varchar(10) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `tanggal_gabung` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `karyawan`
--

INSERT INTO `karyawan` (`id`, `no_induk`, `nama`, `alamat`, `tanggal_lahir`, `tanggal_gabung`) VALUES
(3, 'IP06001', 'Agus', 'Jln Gaja Mada no 12, Surabaya', '1980-01-11', '2005-08-07'),
(4, 'IP06002', 'Amin', 'Jln Imam Bonjol no 11, Mojokerto', '1977-09-03', '2005-08-07'),
(5, 'IP06003', 'Yusuf', 'Jln A Yani Raya 15 No 14 Malang', '1973-08-09', '2006-08-07'),
(6, 'IP06004', 'Alyssa', 'Jln Bungur Sari V no 166, Bandung', '1983-03-18', '2006-09-06'),
(7, 'IP06005', 'Maulana', 'Jln Candi Agung, No 78 Gg 5, Jakarta', '1978-11-10', '2006-09-10'),
(8, 'IP06006', 'Agfika', 'Jln Nangka, Jakarta Timur', '1979-02-07', '2007-01-02'),
(9, 'IP06007', 'James', 'Jln Merpati, 8 Surabaya', '1989-05-18', '2007-04-04'),
(10, 'IP06008', 'Octavanus', 'Jln A Yani 17, B 08 Sidoarjo', '1985-04-14', '2007-05-19'),
(11, 'IP06009', 'Nugroho', 'Jln Duren tiga 167, Jakarta Selatan', '1984-01-01', '2008-01-16'),
(12, 'IP06010', 'Raisa', 'Jln Kelapa Sawit, Jakarta Selatan', '1990-12-17', '2008-08-16');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cuti`
--
ALTER TABLE `cuti`
  ADD PRIMARY KEY (`id_cuti`),
  ADD KEY `cuti_ibfk_1` (`no_induk`);

--
-- Indeks untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `no_induk` (`no_induk`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `cuti`
--
ALTER TABLE `cuti`
  MODIFY `id_cuti` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `cuti`
--
ALTER TABLE `cuti`
  ADD CONSTRAINT `cuti_ibfk_1` FOREIGN KEY (`no_induk`) REFERENCES `karyawan` (`no_induk`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
