import 'package:flutter/material.dart';
import 'package:vitalbreast3/core/data/local/cashe_helper.dart';
import 'package:vitalbreast3/core/doctors/doctor_card.dart';
import 'package:vitalbreast3/core/models/doctor.dart';
import 'package:vitalbreast3/core/data/remote/dio_helper.dart';
import 'package:vitalbreast3/core/network/api_constant.dart';
import 'package:dio/dio.dart';

class BodyDoctorScreen extends StatefulWidget {
  const BodyDoctorScreen({super.key});

  @override
  State<BodyDoctorScreen> createState() => _BodyDoctorScreenState();
}

class _BodyDoctorScreenState extends State<BodyDoctorScreen> {
  List<DoctorsModel> doctors = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
  setState(() {
      isLoading = true;
    });

    try {
      final response = await DioHelper.dio.get(
        ApiConstant.doctor,
        options: Options(
          headers: {
            'Authorization': 'Token ${CasheHelper.getData(key: 'token')}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          doctors = data.map((json) => DoctorsModel.fromJson(json)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to load doctors: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text(error!));
    }

    if (doctors.isEmpty) {
      return const Center(child: Text('No doctors found'));
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return DoctorCard(
            name: doctor.user ?? 'Unknown',
            specialty: doctor.clinics?.firstOrNull?.city ?? 'No specialty',
            rating: doctor.rating ?? '0.0',
            time: doctor.timeSlots ?? 'Not available',
            isAvailable: doctor.isAvailable ?? false,
          );
        },
      ),
    );
  }
}