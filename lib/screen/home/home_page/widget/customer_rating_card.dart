import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class CustomerReviewCard extends StatelessWidget {
  final String userName;
  final int rating;
  final String message;

  const CustomerReviewCard({
    super.key,
    required this.userName,
    required this.rating,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 10),
        _buildMessage(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),
        const SizedBox(width: 12),
        Expanded(child: _buildUserInfo()),
      ],
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 50,
      height: 50,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff5F5F5F),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          userName.isNotEmpty ? userName.substring(0, 1).toUpperCase() : '',
          style: size20_M_bold(),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: size16_M_regular(textColor: blackType1),
        ),
        _buildRatingBar(),
      ],
    );
  }

  Widget _buildRatingBar() {
    return RatingBarIndicator(
      rating: rating.toDouble(),
      itemBuilder: (context, index) =>
          const Icon(Icons.star, color: primaryOrange),
      itemCount: 5,
      itemSize: 15,
      direction: Axis.horizontal,
    );
  }

  Widget _buildMessage() {
    return Text(
      message,
      style: size12_M_regular(textColor: blackType1).copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
