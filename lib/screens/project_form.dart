import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _technologies = "";
  String _projectUrl = "";
  String _projectImageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Project Form',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Project Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Proyek",
                    labelText: "Nama Proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Proyek",
                    labelText: "Deskripsi Proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              // === Technologies ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Flutter, Django, Figma",
                    labelText: "Teknologi yang Digunakan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _technologies = value!;
                    });
                  },
                ),
              ),

              // === Project Link ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "https://github.com/username/project",
                    labelText: "Project URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    // URL wajib diisi.
                    if (value == null || value.trim().isEmpty) {
                      return 'Project URL is required';
                    }

                    // Memeriksa apakah URL valid.
                    final uri = Uri.tryParse(value.trim());

                    if (uri == null ||
                        !uri.hasScheme ||
                        !(uri.scheme == 'http' || uri.scheme == 'https') ||
                        uri.host.isEmpty) {
                      return 'Please enter a valid URL';
                    }

                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      _projectUrl = value!;
                    });
                  },
                ),
              ),
              // === Project Image URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL gambar proyek (opsional)",
                    labelText: "Project Image URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _projectImageUrl = value ?? "";
                  },
                ),
              ),
              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () async {
                      // Validasi formulir
                      if (!_formKey.currentState!.validate()) return;
                      final apiClient = context.read<ApiClient>();
                      final messenger = ScaffoldMessenger.of(context);
                      // Memastikan sudah login
                      final loggedIn = await ensureLoggedIn(context);
                      if (!loggedIn || !context.mounted) return;

                      final authState = context.read<AuthState>();
                      final token = authState.token;
                      // Pengecekan token bertipe nullable
                      if (token == null || token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Token tidak ditemukan. Silakan login kembali.'),
                          ),
                        );
                        return;
                      }

                      // Membuat Project
                      final newProject = Project(
                        title: _title.trim(),
                        description: _description.trim(),
                        technologies: _technologies.trim(),
                        projectUrl: _projectUrl.trim(),
                        projectImageUrl: _projectImageUrl.trim(),
                      );

                      try {
                        // kirim data ke django
                        await apiClient.createProject(
                          newProject,
                          token: token,
                        );

                        if (!context.mounted) return;

                        await showDialog<void>(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Proyek berhasil ditambahkan!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Proyek: $_title'),
                                    Text('Deskripsi: $_description'),
                                    Text('Teknologi: $_technologies'),
                                    Text('Tautan: $_projectUrl'),
                                    Text('Gambar: $_projectImageUrl'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    _formKey.currentState!.reset();

                                    setState(() {
                                      _title = "";
                                      _description = "";
                                      _technologies = "";
                                      _projectUrl = "";
                                      _projectImageUrl = "";
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } on ApiException catch (e) {
                        // Menangani error dari API Django
                        if (!context.mounted) return;

                        messenger.showSnackBar(
                          SnackBar(
                            content: Text('Gagal menambahkan proyek: ${e.message}'),
                          ),
                        );
                      } catch (e) {
                        // Menangani error lainnya, misalnya koneksi internet
                        if (!context.mounted) return;

                        messenger.showSnackBar(
                          SnackBar(
                            content: Text('Terjadi kesalahan: $e'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}