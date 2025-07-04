import 'package:flutter/material.dart';

class MySnackbar {
  static void showError(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      message: message,
      type: SnackbarType.error,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      message: message,
      type: SnackbarType.success,
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      message: message,
      type: SnackbarType.info,
    );
  }

  static void _showSnackbar({
    required BuildContext context,
    required String message,
    required SnackbarType type,
  }) {
    final scaffold = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);

    late final Color backgroundColor;
    late final Color textColor;
    late final IconData icon;

    switch (type) {
      case SnackbarType.error:
        backgroundColor = theme.colorScheme.errorContainer;
        textColor = Colors.white;
        icon = Icons.error_rounded;
        break;
      case SnackbarType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        icon = Icons.check_circle_rounded;
        break;
      case SnackbarType.info:
        backgroundColor = Colors.orangeAccent;
        textColor = Colors.white;
        icon = Icons.info_rounded;
        break;
    }

    scaffold.showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: textColor, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _getTitle(type),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: textColor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close_rounded, color: textColor, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => scaffold.hideCurrentSnackBar(),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 700),
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static String _getTitle(SnackbarType type) {
    switch (type) {
      case SnackbarType.error:
        return 'حدث خطأ';
      case SnackbarType.success:
        return 'تم بنجاح';
      case SnackbarType.info:
        return 'معلومة';
    }
  }
}

enum SnackbarType {
  error,
  success,
  info,
}
