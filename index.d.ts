declare module "@byron-react-native/sheet-picker" {
  import { ViewStyle } from "react-native";
  export interface SheetPickerItemT {
    label: string;
    value: string;
  }
  export interface SheetPickerProps {
    data: SheetPickerItemT[];
    index?: number;
    style?: ViewStyle;
    color?: string;
    fontSize?: number;
    lineSpacing?: number;
    selectedColor?: string;
    onChangeIndex?: (index: number) => void;
  }
  export class ByronSheetPicker<T> extends React.Component<T> {}
  export default class SheetPicker extends React.Component<SheetPickerProps> {}
}
