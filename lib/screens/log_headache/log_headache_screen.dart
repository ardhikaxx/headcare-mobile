import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/widgets.dart';

class LogHeadacheScreen extends StatefulWidget {
  const LogHeadacheScreen({super.key});

  @override
  State<LogHeadacheScreen> createState() => _LogHeadacheScreenState();
}

class _LogHeadacheScreenState extends State<LogHeadacheScreen> {
  int _currentStep = 0;
  int _intensity = 5;
  TimeOfDay _startTime = TimeOfDay.now();
  final List<PainLocation> _selectedLocations = [];
  final List<PainCharacter> _selectedCharacters = [];
  Duration _duration = const Duration(hours: 2);
  final List<String> _selectedSymptoms = [];
  final List<HeadacheTrigger> _selectedTriggers = [];
  bool _tookMedication = false;

  final _symptoms = [
    'Mual',
    'Sensitivitas cahaya',
    'Sensitivitas suara',
    'Pusing',
    'Penglihatan kabur',
    'Kekakuan leher',
  ];

  final _triggers = [
    HeadacheTrigger.lackOfSleep,
    HeadacheTrigger.stress,
    HeadacheTrigger.dehydration,
    HeadacheTrigger.screenTime,
    HeadacheTrigger.skippedMeal,
    HeadacheTrigger.caffeine,
    HeadacheTrigger.exercise,
  ];

  bool get _isLastStep => _currentStep == 4;

  void _nextStep() {
    if (_isLastStep) {
      _submitForm();
    } else {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _submitForm() {
    Navigator.of(context).pushReplacementNamed('/log-headache-confirm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FloatingHeader(
              title: 'Catat Sakit Kepala',
              subtitle: 'Langkah ${_currentStep + 1} dari 5',
              showBack: true,
            ),
            const SizedBox(height: 16),
            // Progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: List.generate(5, (index) {
                  return Expanded(
                    child: Container(
                      height: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= _currentStep
                            ? AppColors.primary
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildStepContent(),
              ),
            ),
            // Bottom buttons
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.borderLight)),
              ),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: SecondaryButton(
                        label: 'Kembali',
                        onPressed: _prevStep,
                        isExpanded: true,
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: _isLastStep ? 'Simpan Episode' : 'Lanjut',
                      onPressed: _nextStep,
                      isExpanded: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildIntensityStep();
      case 1:
        return _buildLocationStep();
      case 2:
        return _buildDurationStep();
      case 3:
        return _buildSymptomsStep();
      case 4:
        return _buildTriggersStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildIntensityStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Intensitas Nyeri', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Seberapa intens nyeri sakit kepala Anda pada skala 1-10?',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 32),
        Center(
          child: Text(
            '$_intensity',
            style: AppTypography.displayLarge.copyWith(
              color: _getIntensityColor(),
              fontSize: 64,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            _getIntensityLabel(),
            style: AppTypography.titleMedium.copyWith(color: _getIntensityColor()),
          ),
        ),
        const SizedBox(height: 24),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: _getIntensityColor(),
            inactiveTrackColor: AppColors.border,
            thumbColor: _getIntensityColor(),
            overlayColor: _getIntensityColor().withAlpha(30),
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            value: _intensity.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (v) => setState(() => _intensity = v.round()),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ringan', style: AppTypography.caption),
            Text('Sedang', style: AppTypography.caption),
            Text('Berat', style: AppTypography.caption),
          ],
        ),
        const SizedBox(height: 32),
        Text('Kapan sakit kepala dimulai?', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: _startTime,
            );
            if (time != null) setState(() => _startTime = time);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.clock, size: 20, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}',
                  style: AppTypography.headlineMedium,
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lokasi Nyeri', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Di mana Anda merasakan nyeri? (Pilih semua yang sesuai)',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        ...PainLocation.values.map(
          (location) {
            final isSelected = _selectedLocations.contains(location);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedLocations.remove(location);
                  } else {
                    _selectedLocations.add(location);
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withAlpha(15)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(_getLocationName(location), style: AppTypography.bodyLarge),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Text('Karakter Nyeri', style: AppTypography.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Bagaimana Anda mendeskripsikan rasa nyeri?',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PainCharacter.values.map(
            (character) {
              final isSelected = _selectedCharacters.contains(character);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedCharacters.remove(character);
                    } else {
                      _selectedCharacters.add(character);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withAlpha(15) : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(
                    _getCharacterName(character),
                    style: AppTypography.labelLarge.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildDurationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Durasi', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Berapa lama sakit kepala berlangsung?',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Text(
                _durationFormatted,
                style: AppTypography.displaySmall,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DurationButton(
                    icon: Icons.remove,
                    onTap: () {
                      setState(() {
                        if (_duration.inMinutes > 15) {
                          _duration -= const Duration(minutes: 15);
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Text('Jam', style: AppTypography.caption),
                      Text(
                        '${_duration.inHours}',
                        style: AppTypography.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Text('Menit', style: AppTypography.caption),
                      Text(
                        '${_duration.inMinutes % 60}',
                        style: AppTypography.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  _DurationButton(
                    icon: Icons.add,
                    onTap: () {
                      setState(() {
                        _duration += const Duration(minutes: 15);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gejala yang Menyertai', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Apakah Anda mengalami salah satu gejala berikut?',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        ..._symptoms.map(
          (symptom) {
            final isSelected = _selectedSymptoms.contains(symptom);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedSymptoms.remove(symptom);
                  } else {
                    _selectedSymptoms.add(symptom);
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withAlpha(15)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(symptom, style: AppTypography.bodyLarge),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTriggersStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pemicu yang Mungkin', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Menurut Anda, apa yang mungkin memicu sakit kepala ini?',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _triggers.map(
            (trigger) {
              final isSelected = _selectedTriggers.contains(trigger);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedTriggers.remove(trigger);
                    } else {
                      _selectedTriggers.add(trigger);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withAlpha(15) : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(
                    _getTriggerName(trigger),
                    style: AppTypography.labelLarge.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 24),
        Text('Apakah Anda mengonsumsi obat?', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() {
                  _tookMedication = true;
                }),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _tookMedication
                        ? AppColors.primary.withAlpha(15)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _tookMedication ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(
                    'Ya',
                    style: AppTypography.labelLarge.copyWith(
                      color: _tookMedication ? AppColors.primary : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() {
                  _tookMedication = false;
                }),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: !_tookMedication
                        ? AppColors.primary.withAlpha(15)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: !_tookMedication ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(
                    'Tidak',
                    style: AppTypography.labelLarge.copyWith(
                      color: !_tookMedication ? AppColors.primary : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_tookMedication) ...[
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Nama obat (opsional)',
            ),
              onChanged: (v) {},
          ),
        ],
        const SizedBox(height: 20),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Catatan tambahan (opsional)',
          ),
          maxLines: 3,
          onChanged: (v) {},
        ),
      ],
    );
  }

  String get _durationFormatted {
    final h = _duration.inHours;
    final m = _duration.inMinutes % 60;
    return '${h}h ${m}m';
  }

  Color _getIntensityColor() {
    if (_intensity <= 3) return AppColors.success;
    if (_intensity <= 6) return AppColors.warning;
    return AppColors.danger;
  }

  String _getIntensityLabel() {
    if (_intensity <= 3) return 'Ringan';
    if (_intensity <= 6) return 'Sedang';
    return 'Berat';
  }

  String _getLocationName(PainLocation location) {
    switch (location) {
      case PainLocation.forehead:
        return 'Dahi';
      case PainLocation.temples:
        return 'Pelipis';
      case PainLocation.backOfHead:
        return 'Belakang Kepala';
      case PainLocation.aroundEyes:
        return 'Sekitar Mata';
      case PainLocation.wholeHead:
        return 'Seluruh Kepala';
      case PainLocation.neck:
        return 'Leher';
    }
  }

  String _getCharacterName(PainCharacter character) {
    switch (character) {
      case PainCharacter.throbbing:
        return 'Berdenyut';
      case PainCharacter.pressure:
        return 'Tekanan';
      case PainCharacter.sharp:
        return 'Tajam';
      case PainCharacter.dull:
        return 'Tumpul';
      case PainCharacter.pulsating:
        return 'Berdenyut Nadi';
    }
  }

  String _getTriggerName(HeadacheTrigger trigger) {
    switch (trigger) {
      case HeadacheTrigger.lackOfSleep:
        return 'Kurang Tidur';
      case HeadacheTrigger.stress:
        return 'Stres';
      case HeadacheTrigger.dehydration:
        return 'Dehidrasi';
      case HeadacheTrigger.screenTime:
        return 'Waktu Layar';
      case HeadacheTrigger.skippedMeal:
        return 'Melewatkan Makan';
      case HeadacheTrigger.caffeine:
        return 'Kafein';
      case HeadacheTrigger.exercise:
        return 'Olahraga';
      default:
        return trigger.toString().split('.').last;
    }
  }
}

class _DurationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _DurationButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
    );
  }
}
