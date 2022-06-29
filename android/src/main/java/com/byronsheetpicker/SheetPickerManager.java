// SheetPickerModule.java

package com.byronsheetpicker;

import android.graphics.Color;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.byronsheetpicker.wheel.WheelPicker;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

import java.util.ArrayList;
import java.util.Map;

public class SheetPickerManager extends SimpleViewManager<RNByronWheelPicker> {

    @NonNull
    @Override
    public String getName() {
        return "ByronSheetPicker";
    }

    @NonNull
    @Override
    protected RNByronWheelPicker createViewInstance(@NonNull ThemedReactContext reactContext) {
        return new RNByronWheelPicker(reactContext);
    }

    @Nullable
    @Override
    public Map<String, Object> getExportedCustomDirectEventTypeConstants() {
        String onChangeIndex = RNByronWheelPicker.EVETN_NAME_CHANGE_INDEX;
        return MapBuilder.<String, Object>builder()
                .put(onChangeIndex, MapBuilder.of("registrationName", onChangeIndex)).build();
    }

    @ReactProp(name="data")
    public void setData(RNByronWheelPicker picker, ReadableArray data) {
        if (picker == null || data.size() == 0) {
            return;
        }
        ArrayList<String> labelData = new ArrayList<>();
        for (int i=0; i<data.size(); i++) {
            ReadableMap item = data.getMap(i);
            labelData.add(item.getString("label"));
        }
        picker.setData(labelData);
    }

    @ReactProp(name="index")
    public void setIndex(final RNByronWheelPicker picker, final int index) {
        if (picker == null || picker.getState() == WheelPicker.SCROLL_STATE_IDLE) {
            return;
        }
        // 必须放在异步，否则不能确保生效 https://github.com/AigeStudio/WheelPicker/issues/156
        new Thread(new Runnable() {
            @Override
            public void run() {
                picker.setSelectedItemPosition(index);
                picker.invalidate();
            }
        });
    }

    @ReactProp(name="color")
    public void setColor(final RNByronWheelPicker picker, String color) {
        picker.setItemTextColor(Color.parseColor(color));
    }

    @ReactProp(name="selectedColor")
    public void setSelectedColor(final RNByronWheelPicker picker, String selectedColor) {
        picker.setSelectedItemTextColor(Color.parseColor(selectedColor));
    }

    @ReactProp(name="fontSize")
    public void setFontSize(final RNByronWheelPicker picker, final int fontSize) {
        picker.setItemTextSize(fontSize);
    }

    @ReactProp(name="lineSpacing")
    public void setLineSpacing(final RNByronWheelPicker picker, final int lineSpacing) {
        picker.setItemSpace(lineSpacing);
    }
}
