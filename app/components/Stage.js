import React from 'react';
import { StyleSheet, View } from 'react-native';
import Cell from './Cell';

const Stage = ({ stage }) => (
  <View style={styles.stage}>
    {stage.map(row => row.map((cell, x) => <Cell key={x} type={cell[0]} />))}
  </View>
);

const styles = StyleSheet.create({
  stage: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    width: 30 * 12, // width * columns
  },
});

export default Stage;
