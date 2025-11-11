import 'package:flutter/material.dart';
import 'package:stac_framework/stac_framework.dart';
import '../widgets/stac_chat_message.dart';

class StacChatMessageParser extends StacParser<StacChatMessage> {
  const StacChatMessageParser();

  @override
  Widget parse(BuildContext context, StacChatMessage widget) {
    return _ChatMessageWidget(widget: widget);
  }
  
  @override
  StacChatMessage getModel(Map<String, dynamic> json) {
    // TODO: implement getModel
    throw UnimplementedError();
  }
  
  @override
  // TODO: implement type
  String get type => throw UnimplementedError();
}

class _ChatMessageWidget extends StatefulWidget {
  final StacChatMessage widget;

  const _ChatMessageWidget({required this.widget});

  @override
  State<_ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<_ChatMessageWidget> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<bool> _switchValues;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    // Initialize switch values from widget
    _switchValues = widget.widget.switchButtonEntities
        .map((e) => e.value)
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return widget.widget.errorText ?? 'This field is required';
    }

    if (widget.widget.validationRegex != null &&
        widget.widget.validationRegex!.isNotEmpty) {
      final regex = RegExp(widget.widget.validationRegex!);
      if (!regex.hasMatch(value)) {
        return widget.widget.errorText ?? 'Invalid format';
      }
    }

    return null;
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Print the email value
      print('Email submitted: ${_controller.text}');

      // Print switch states
      for (int i = 0; i < widget.widget.switchButtonEntities.length; i++) {
        print(
          '${widget.widget.switchButtonEntities[i].title}: ${_switchValues[i]}',
        );
      }

      // Print selected option if any
      if (_selectedOption != null) {
        print('Selected option: $_selectedOption');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Chat message with icon
              Row(
                children: [
                  if (widget.widget.iconPath.isNotEmpty) ...[
                    Image.asset(
                      widget.widget.iconPath,
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.email, size: 24);
                      },
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      widget.widget.chatMessage,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Email input field
              if (widget.widget.canReply)
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: widget.widget.label,
                    hintText: 'Enter your ${widget.widget.label.toLowerCase()}',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
              const SizedBox(height: 16),

              // Options as chips
              if (widget.widget.optionEntities.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.widget.optionEntities.map((option) {
                    final isSelected = _selectedOption == option.value;
                    return FilterChip(
                      label: Text(option.title ?? option.value),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedOption = selected ? option.value : null;
                        });
                      },
                      avatar: option.url != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(option.url!),
                            )
                          : null,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],

              // Switch buttons
              if (widget.widget.switchButtonEntities.isNotEmpty)
                ...List.generate(widget.widget.switchButtonEntities.length, (
                  index,
                ) {
                  final switchButton =
                      widget.widget.switchButtonEntities[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          switchButton.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Switch(
                          value: _switchValues[index],
                          onChanged: switchButton.isDisabled
                              ? null
                              : (value) {
                                  setState(() {
                                    _switchValues[index] = value;
                                  });
                                },
                        ),
                      ],
                    ),
                  );
                }),
              const SizedBox(height: 16),

              // Submit button
              if (widget.widget.canReply)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text('Submit'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
