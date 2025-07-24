import React from 'react';
import { StyleSheet, View } from 'react-native';
import { TETROMINOS } from '../game-engine';

const Cell = ({ type }) => (
  <View
    style={[styles.cell, { backgroundColor: TETROMINOS[type].color }]}
  />
);

const styles = StyleSheet.create({
  cell: {
    width: 30,
    height: 30,
    borderWidth: 1,
    borderColor: 'black',
  },
});

export default Cell;
