package com.byronsheetpicker;

import android.annotation.SuppressLint;
import android.graphics.Color;

import com.byronsheetpicker.wheel.WheelPicker;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;

/**
 * @author <a href="mailto:lesliesam@hotmail.com"> Sam Yu </a>
 */
@SuppressLint("ViewConstructor")
public class RNByronWheelPicker extends WheelPicker {
    private int mState;
    private final RCTEventEmitter eventEmitter;
    public static final String EVETN_NAME_CHANGE_INDEX = "onChangeIndex";

    public RNByronWheelPicker(ReactContext reactContext) {
        super(reactContext);
        eventEmitter = reactContext.getJSModule(RCTEventEmitter.class);
        // 设置滚轮选择器是否显示幕布
        setCurtain(true);
        // 设置滚轮选择器是否有空气感
        setAtmospheric(true);
        // 滚轮选择器是否开启卷曲效果
        setCurved(true);
        // 设置滚轮选择器数据项的对齐方式 ALIGN_CENTER = 0, ALIGN_LEFT = 1, ALIGN_RIGHT = 2;
        setItemAlign(0);
        setOnWheelChangeListener(new OnWheelChangeListener() {
            @Override
            public void onWheelScrolled(int offset) {
            }

            @Override
            public void onWheelSelected(int position) {
                WritableMap map = new WritableNativeMap();
                map.putInt("index", position);
                eventEmitter.receiveEvent(getId(), EVETN_NAME_CHANGE_INDEX, map);
            }

            @Override
            public void onWheelScrollStateChanged(int state) {
                mState = state;
            }
        });
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
    }

    public int getState() {
        return mState;
    }
}

