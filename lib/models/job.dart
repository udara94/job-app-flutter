import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String? employerName;
  String? employerLogo;
  String? jobId;
  String? jobEmploymentType;
  String? jobTitle;
  String? jobApplyLink;
  String? jobDescription;
  String? jobCountry;
  String? jobGoogleLink;
  int? jobPostedAtTimestamp;
  JobHighlights? jobHighlights;

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
    this.jobPostedAtTimestamp
  });

  factory Job.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return Job(
      employerName: data != null && data.containsKey('employer_name') ? data['employer_name'] : "",
      employerLogo: data != null && data.containsKey('employer_logo') ? data['employer_logo'] : "",
      jobId: data != null && data.containsKey('job_id') ? data['job_id'] : "",
      jobEmploymentType: data != null && data.containsKey('job_employment_type') ? data['job_employment_type'] : "",
      jobTitle: data != null && data.containsKey('job_title') ? data['job_title'] : "",
      jobApplyLink: data != null && data.containsKey('job_apply_link') ? data['job_apply_link'] : "",
      jobDescription: data != null && data.containsKey('job_description') ? data['job_description'] : "",
      jobCountry: data != null && data.containsKey('job_country') ? data['job_country'] : "",
      jobGoogleLink: data != null && data.containsKey('job_google_link') ? data['job_google_link'] : "",
      jobHighlights: data != null && data.containsKey('job_highlights') ? JobHighlights.fromMap(data['job_highlights']) : null,
      jobPostedAtTimestamp: data != null && data.containsKey('job_posted_at_timestamp') ? data['job_posted_at_timestamp'] : 0,
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

  Map<String, dynamic> toMap(){
    return {
      'employer_name': employerName,
      'employer_logo': employerLogo,
      'job_id':jobId,
      'job_employment_type': jobEmploymentType,
      'job_title': jobTitle,
      'job_apply_link': jobApplyLink,
      'job_description': jobDescription,
      'job_country': jobCountry,
      'job_google_link': jobGoogleLink,
      'job_highlights': jobHighlights?.toMap(),
      'job_posted_at_timestamp': jobPostedAtTimestamp,
    };
  }

  Map<String, Object?> toJson(){
    return {
      'employer_name': employerName,
      'employer_logo': employerLogo,
      'job_id':jobId,
      'job_employment_type': jobEmploymentType,
      'job_title': jobTitle,
      'job_apply_link': jobApplyLink,
      'job_description': jobDescription,
      'job_country': jobCountry,
      'job_google_link': jobGoogleLink,
      'job_highlights': jobHighlights?.toJson(),
      'job_posted_at_timestamp': jobPostedAtTimestamp,
    };
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

  Map<String, dynamic> toMap(){
    return {
      'Qualifications': qualifications,
      'Responsibilities': responsibilities,
    };
  }

  Map<String, Object?> toJson(){
    return {
      'Qualifications': qualifications,
      'Responsibilities': responsibilities,
    };
  }
  factory JobHighlights.fromJson(Map<String, dynamic> json) {
    return JobHighlights(
      qualifications: List<String>.from(json['Qualifications'] ?? []),
      responsibilities: List<String>.from(json['Responsibilities'] ?? []),
    );
  }
}

