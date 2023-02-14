## Setup

1. Set your API Key inside the `.env.example` file :

```
OPEN_AI_API_KEY=<YOUR_KEY_HERE>
```

2. if you're willing to change the environment variable name, then you should change it as well inside the `lib/env/env.dart`, otherwise if you're not changing it, pass directly to the next step.
3. Change `.env.example` file name to `.env`.
4. Run `dart pub get`.
5. Run `dart run build_runner build`.
6. Run the `lib/main.dart` from your IDE, alternatively, Run `dart run lib/main.dart` from your command line.
7. That's it, now run your main.dart and other dart files.
