import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String? employerName; //
  String? employerLogo; //
  String? jobId; //
  String? jobEmploymentType; //
  String? jobTitle; //
  String? jobApplyLink; //
  String? jobDescription; //
  String? jobCountry; //
  String? jobGoogleLink; //
  JobHighlights? jobHighlights; //

  Job({
    this.employerName,
    this.employerLogo,
    this.jobId,
    this.jobEmploymentType,
    this.jobTitle,
    this.jobApplyLink,
    this.jobDescription,
    this.jobCountry,
    this.jobGoogleLink,
    this.jobHighlights,
  });

  factory Job.fromDocument(DocumentSnapshot doc) {
    return Job(
      employerName: doc['employer_name'] ?? "",
      employerLogo: doc['employer_logo'] ?? "",
      jobId: doc['job_id'] ?? "",
      jobEmploymentType: doc['job_employment_type'] ?? "",
      jobTitle: doc['job_title'] ?? "",
      jobApplyLink: doc['job_apply_link'] ?? "",
      jobDescription: doc['job_description'] ?? "",
      jobCountry: doc['job_country'] ?? "",
      jobGoogleLink: doc['job_google_link'] ?? "",
      jobHighlights: JobHighlights.fromMap(doc['job_highlights']),
    );
  }

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      employerName: json['employer_name'],
      employerLogo: json['employer_logo'],
      jobId: json['job_id'],
      jobEmploymentType: json['job_employment_type'],
      jobTitle: json['job_title'],
      jobApplyLink: json['job_apply_link'],
      jobDescription: json['job_description'],
      jobGoogleLink: json['job_google_link'],
      jobHighlights: JobHighlights.fromJson(json['job_highlights']),
    );
  }
}

class JobHighlights {
  List<String>? qualifications;
  List<String>? responsibilities;

  JobHighlights({
    this.qualifications,
    this.responsibilities,
  });

  factory JobHighlights.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return JobHighlights(
      qualifications: List<String>.from(doc['Qualifications'] ?? []),
      responsibilities: List<String>.from(doc['Responsibilities'] ?? []),
    );
  }

  factory JobHighlights.fromMap(Map<String, dynamic>? map) {
    if (map == null) return JobHighlights();

    return JobHighlights(
      qualifications: List<String>.from(map['Qualifications'] ?? []),
      responsibilities: List<String>.from(map['Responsibilities'] ?? []),
    );
  }

  factory JobHighlights.fromJson(Map<String, dynamic> json) {
    return JobHighlights(
      qualifications: List<String>.from(json['Qualifications'] ?? []),
      responsibilities: List<String>.from(json['Responsibilities'] ?? []),
    );
  }
}

