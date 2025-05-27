import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PictureState extends Equatable {
  @override
  List<Object> get props => [];
}

class PictureInitial extends PictureState {}

class PictureLoading extends PictureState {}

class PictureUpdated extends PictureState {
  final String imageUrl;

  PictureUpdated({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class PictureError extends PictureState {
  final String message;

  PictureError({required this.message});

  @override
  List<Object> get props => [message];
}
