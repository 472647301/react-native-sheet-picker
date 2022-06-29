# react-native-sheet-picker

## Getting started

`$ npm install @byron-react-native/sheet-picker --save`

## Usage
```javascript
import SheetPicker from '@byron-react-native/sheet-picker';

const SheetPicker1 = () => {
  onChangeIndex = index => {
    console.log(' >> onChangeIndex', index);
  };
  return <SheetPicker data={data1} onChangeIndex={onChangeIndex} />;
};

```

## Screenshot

<img src="https://github.com/472647301/react-native-sheet-picker/blob/main/example/pic.png?raw=true" width="1038">