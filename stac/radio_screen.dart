import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: "radio_screen")
StacWidget radioScreen() {
  return StacScaffold(
    body: StacCenter(
      child: StacForm(
        child: StacRadioGroup(
          id: 'gender_group',
          groupValue: 'male',
          child: StacColumn(
            children: [
              StacRadio(
                radioType: StacRadioType.material,
                value: 'male',
                groupId: 'gender_group',
                onChanged: StacAction(
                  jsonData: {'action_type': 'send_message', 'message': 'male'},
                ),
              ),
              StacRadio(
                radioType: StacRadioType.material,
                value: 'female',
                groupId: 'gender_group',
                onChanged: StacAction(
                  jsonData: {
                    'action_type': 'send_message',
                    'message': 'female',
                  },
                ),
              ),
              StacElevatedButton(
                child: StacText(data: 'Submit'),
                onPressed: StacAction(
                  jsonData: {
                    'action_type': 'send_message',
                    'message': 'Selected',
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
