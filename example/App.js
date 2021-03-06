/**
 * Sample React Native App
 *
 * adapted from App.js generated by the following command:
 *
 * react-native init example
 *
 * https://github.com/facebook/react-native
 */

import React, {Component} from 'react';
import {StyleSheet, Text, View} from 'react-native';
import SheetPicker from '@byron-react-native/sheet-picker';
import Modal from 'react-native-modal';
import {city} from './city';

const data1 = [];

for (let key in city) {
  if (city[key].length) {
    data1.push({
      value: key,
      label: city[key][0].province,
    });
  }
}

export default class App extends Component {
  state = {
    visible1: false,
    visible2: false,
    visible3: false,
  };
  openSheetPicker1 = () => {
    this.setState({visible1: true});
  };
  closeSheetPicker1 = () => {
    this.setState({visible1: false});
  };

  openSheetPicker2 = () => {
    this.setState({visible2: true});
  };
  closeSheetPicker2 = () => {
    this.setState({visible2: false});
  };

  openSheetPicker3 = () => {
    this.setState({visible3: true});
  };
  closeSheetPicker3 = () => {
    this.setState({visible3: false});
  };

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome} onPress={this.openSheetPicker1}>
          ☆SheetPicker Modal 1☆
        </Text>
        <Text style={styles.welcome} onPress={this.openSheetPicker2}>
          ☆SheetPicker Modal 2☆
        </Text>
        <Text style={styles.welcome} onPress={this.openSheetPicker3}>
          ☆SheetPicker Modal 3☆
        </Text>
        <Modal
          isVisible={this.state.visible1}
          onBackdropPress={this.closeSheetPicker1}
          style={styles.modal}>
          <View style={styles.list}>
            <SheetPicker1 />
          </View>
        </Modal>
        <Modal
          isVisible={this.state.visible2}
          onBackdropPress={this.closeSheetPicker2}
          style={styles.modal}>
          <View style={styles.list}>
            <SheetPicker2 />
          </View>
        </Modal>
        <Modal
          isVisible={this.state.visible3}
          onBackdropPress={this.closeSheetPicker3}
          style={styles.modal}>
          <View style={styles.list}>
            <SheetPicker3 />
          </View>
        </Modal>
      </View>
    );
  }
}

const SheetPicker1 = () => {
  onChangeIndex = index => {
    console.log(' >> onChangeIndex', index);
  };
  return <SheetPicker data={data1} onChangeIndex={onChangeIndex} />;
};

const SheetPicker2 = () => {
  onChangeIndex = index => {
    console.log(' >> onChangeIndex', index);
  };
  return (
    <>
      <SheetPicker data={data1} onChangeIndex={onChangeIndex} />
      <SheetPicker data={data1} onChangeIndex={onChangeIndex} />
    </>
  );
};

const SheetPicker3 = () => {
  onChangeIndex = index => {
    console.log(' >> onChangeIndex', index);
  };
  return (
    <>
      <SheetPicker data={data1} onChangeIndex={onChangeIndex} />
      <SheetPicker data={data1} onChangeIndex={onChangeIndex} />
      <SheetPicker data={data1} onChangeIndex={onChangeIndex} />
    </>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  modal: {
    flex: 1,
    margin: 0,
    justifyContent: 'flex-end',
  },
  list: {
    height: 240,
    backgroundColor: '#fff',
    flexDirection: 'row',
  },
});
