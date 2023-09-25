part of '../details_screen.dart';

class _Label extends Text {
  _Label(String text, bool isDark)
      : super(
          text,
          style: TextStyle(
            color: isDark
                ? AppColors.whiteGrey.withOpacity(0.6)
                : AppColors.black.withOpacity(0.6),
            height: 0.8,
          ),
        );
}


class _ItemAbout extends StatelessWidget {
  final Item item;

  const _ItemAbout(this.item);

  @override
  Widget build(BuildContext context) {
    final slideController = ItemInfoStateProvider.of(context).slideController;

    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 19, horizontal: 27),
          physics: scrollable
              ? BouncingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        children: <Widget>[
          _buildDescription(item.description),
          SizedBox(height: 28),
          _buildHeightWeight(item.name, item.size, context, isDark),
        ],
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(height: 1.3),
    );
  }

  Widget _buildHeightWeight(
      String height, String weight, BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 8),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('Model', isDark),
                SizedBox(height: 11),
                Text(
                  height,
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('Size', isDark),
                SizedBox(height: 11),
                Text(weight,
                    style: TextStyle(
                      height: 0.8,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
