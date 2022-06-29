import React from "react";
import { requireNativeComponent, Platform, PixelRatio } from "react-native";

const pixelRatio = PixelRatio.get();

export const ByronSheetPicker = requireNativeComponent("ByronSheetPicker");

function SheetPicker(props) {
  const onChangeIndex = (event) => {
    if (!props.onChangeIndex) {
      return;
    }
    const { index } = event.nativeEvent;
    props.onChangeIndex(index);
  };

  let fontSize = props.fontSize || 16;
  if (Platform.OS === "android") {
    fontSize = Math.ceil(fontSize * pixelRatio);
  }

  return (
    <ByronSheetPicker
      index={0}
      lineSpacing={10}
      color={"#555555"}
      selectedColor={"#292929"}
      style={{ flex: 1 }}
      {...props}
      fontSize={fontSize}
      onChangeIndex={onChangeIndex}
    />
  );
}

export default React.memo(SheetPicker);
