import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: "login_screen")
StacWidget loginScreen() {
  return StacScaffold(
    body: StacSingleChildScrollView(
      padding: const StacEdgeInsets.all(16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.max,
        children: [
          StacColumn(
            children: [
              const StacSizedBox(height: 48),
              StacColumn(
                children: [
                  StacContainer(
                    width: 80,
                    height: 80,
                    decoration: StacBoxDecoration(
                      color: StacColors.primary,
                      borderRadius: StacBorderRadius.circular(20),
                    ),
                    child: StacIcon(
                      icon: StacIcons.person,
                      size: 40,
                      color: StacColors.white,
                    ),
                  ),
                  const StacSizedBox(height: 24),
                  StacText(
                    data: 'Welcome Back',
                    style: StacTextStyle(
                      fontSize: 24,
                      fontWeight: StacFontWeight.bold,
                    ),
                  ),
                  const StacSizedBox(height: 8),
                  StacText(
                    data: 'Sign in to continue',
                    style: StacTextStyle(fontSize: 16, color: StacColors.grey),
                  ),
                ],
              ),
              const StacSizedBox(height: 48),
            ],
          ),
          StacForm(
            autovalidateMode: StacAutovalidateMode.always,
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacTextFormField(
                  id: 'username',
                  decoration: const StacInputDecoration(
                    labelText: 'Username',
                    prefixIcon: StacIcon(icon: StacIcons.person_outline),
                  ),
                  textInputAction: StacTextInputAction.next,
                  // onChanged: StacAction(
                  //   jsonData: {
                  //     "actionType": "customSetValue",
                  //     "key": "form.username",
                  //     "value": {"actionType": "getFormValue", "id": "username"},
                  //   },
                  // ),
                ),
                const StacSizedBox(height: 16),
                StacTextFormField(
                  id: 'password',
                  obscureText: true,
                  decoration: const StacInputDecoration(
                    labelText: 'Password',
                    prefixIcon: StacIcon(icon: StacIcons.lock_outline),
                  ),
                  textInputAction: StacTextInputAction.done,
                  maxLines: 1,
                  obscuringCharacter: '*',
                  // onChanged: StacAction(
                  //   jsonData: {
                  //     "actionType": "customSetValue",
                  //     "key": "form.password",
                  //     "value": {"actionType": "getFormValue", "id": "password"},
                  //   },
                  // ),
                ),
                const StacSizedBox(height: 32),
                StacFilledButton(
                  onPressed: StacAction(
                    jsonData: {
                      "actionType": "validateForm",
                      "isValid": {
                        "actionType": "http.post",
                        "url": "auth/login",
                        "payload": {
                          "username": {
                            "actionType": "getFormValue",
                            "id": "form.username",
                          },
                          "password": {
                            "actionType": "getFormValue",
                            "id": "form.password",
                          },
                        },
                        "successNavigate": "/home_screen",
                      },
                    },
                  ),
                  child: StacText(data: 'Sign In'),
                ),
              ],
            ),
          ),

          const StacSizedBox(height: 32),
        ],
      ),
    ),
  );
}
