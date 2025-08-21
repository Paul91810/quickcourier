import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcourier/models/tracking_model.dart';
import 'package:quickcourier/widgets/custom_appbar.dart';
import '../providers/tracking_provider.dart';

class ShipmentTrackingScreen extends StatelessWidget {
  const ShipmentTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<TrackingProvider>();

    return Scaffold(
      appBar: const CustomAppbar(title: 'Shipment Tracking'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _TrackingInputBar(
                controller: p.trackingCtrl,
                onSubmit: () => context.read<TrackingProvider>().track(),
              ),
              const SizedBox(height: 16),
              const Expanded(child: _ResultArea()),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrackingInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  const _TrackingInputBar({required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<TrackingProvider, bool>(
      (p) => p.state == LoadState.loading,
    );
    return Row(
      children: [
        Expanded(
          child: 
          
          TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: 'Tracking Number',
              hintText: 'e.g., TRK123456',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              filled: true,
            ),
            onSubmitted: (_) => onSubmit(),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: isLoading ? null : onSubmit,
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.search),
            label: const Text('Track'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary, 
              foregroundColor: Theme.of(
                context,
              ).colorScheme.onPrimary, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultArea extends StatelessWidget {
  const _ResultArea();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TrackingProvider>();
    switch (provider.state) {
      case LoadState.idle:
        return const _EmptyState();
      case LoadState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadState.error:
        return _ErrorState(message: provider.error ?? 'Something went wrong');
      case LoadState.success:
        final s = provider.shipment!;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StatusCard(shipment: s),
              const SizedBox(height: 12),
              _Timeline(events: s.events),
            ],
          ),
        );
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.local_shipping, size: 48),
            SizedBox(height: 8),
            Text('Enter a tracking number to see status'),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Theme.of(context).colorScheme.errorContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final Shipment shipment;
  const _StatusCard({required this.shipment});

  Color _badgeColor(BuildContext context) {
    final s = shipment.status.toLowerCase();
    if (s.contains('delivered')) return Colors.green;
    if (s.contains('out for delivery')) return Colors.orange;
    if (s.contains('in transit')) return Colors.blue;
    if (s.contains('picked up')) return Colors.purple;
    return Theme.of(context).colorScheme.primary;
  }

  IconData _statusIcon() {
    final s = shipment.status.toLowerCase();
    if (s.contains('delivered')) return Icons.check_circle;
    if (s.contains('out for delivery')) return Icons.delivery_dining;
    if (s.contains('in transit')) return Icons.local_shipping;
    if (s.contains('picked up')) return Icons.inventory_2;
    return Icons.info;
  }

  String _fmtDT(DateTime? dt) {
    if (dt == null) return '-';
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final badgeColor = _badgeColor(context);
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      color: theme.colorScheme.surface, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Row(
              children: [
                Icon(_statusIcon(), size: 28, color: badgeColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    shipment.status,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: badgeColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    shipment.trackingNumber,
                    style: TextStyle(
                      color: badgeColor,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.update, size: 18),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Last updated: ${_fmtDT(shipment.lastUpdated)}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.event, size: 18),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'ETA: ${_fmtDT(shipment.eta)}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<TrackingEvent> events;
  const _Timeline({required this.events});

  String _fmtDT(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surface, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tracking Timeline', style: theme.textTheme.titleMedium),
            const Divider(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              separatorBuilder: (_, __) => const Divider(height: 8),
              itemBuilder: (_, i) {
                final e = events[i];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.location_on),
                  title: Text(e.status),
                  subtitle: Text('${e.location} • ${_fmtDT(e.time)}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
