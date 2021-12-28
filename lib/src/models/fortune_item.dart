import 'package:flutter/material.dart';

///Giá tri may mắn phần tử vòng quay
class FortuneItem {
  FortuneItem(this.value, this.color, {this.priority, this.icon});

  final String value;
  final Color color;

  ///Dộ ưu tiên quay trúng - là số lần xuất hiện trong danh sách xoay trúng
  ///Mặc định [priority] = 1
  final int? priority;
  final Widget? icon;
}