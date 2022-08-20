import 'package:bilfoot/data/models/player_model.dart';
import 'package:flutter/material.dart';

class ProfilePagePhoto extends StatelessWidget {
  final PlayerModel playerModel;
  final double imageSize = 100;

  const ProfilePagePhoto({required this.playerModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: playerModel.imageUrl == null
                  ? Image.asset(
                      "assets/images/default_avatar.jpg",
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      playerModel.imageUrl!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox.square(dimension: 20),
          Text(
            playerModel.fullName,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            playerModel.email,
            style: Theme.of(context).textTheme.overline,
          ),
          // playerModel.pointerNum == 0 ? Container() : _buildPointLabel(),
        ],
      ),
    );
  }

  Widget _buildPointLabel() {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.amber),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 20),
            const SizedBox.square(dimension: 5),
            Text(
                '${playerModel.averagePoint.toStringAsFixed(1)} (${playerModel.pointerNum})')
          ],
        ),
      ),
    );
  }
}
