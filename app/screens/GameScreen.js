import React, { useState } from 'react';
import { StyleSheet, View, Text, Button, TouchableOpacity } from 'react-native';
import Stage from '../components/Stage';
import { createStage, checkCollision } from '../game-engine/board';
import { randomTetromino, TETROMINOS } from '../game-engine';
import { STAGE_WIDTH } from '../game-engine/board';

const GameScreen = () => {
  const [stage, setStage] = useState(createStage());
  const [player, setPlayer] = useState({
    pos: { x: 0, y: 0 },
    tetromino: TETROMINOS[0].shape,
    collided: false,
  });

  const updatePlayerPos = ({ x, y, collided }) => {
    setPlayer(prev => ({
      ...prev,
      pos: { x: (prev.pos.x += x), y: (prev.pos.y += y) },
      collided,
    }));
  };

  const resetPlayer = () => {
    setPlayer({
      pos: { x: STAGE_WIDTH / 2 - 2, y: 0 },
      tetromino: randomTetromino().shape,
      collided: false,
    });
  };

  const move = dir => {
    if (!checkCollision(player, stage, { x: dir, y: 0 })) {
      updatePlayerPos({ x: dir, y: 0 });
    }
  };

  const startGame = () => {
    setStage(createStage());
    resetPlayer();
  };

  const drop = () => {
    if (!checkCollision(player, stage, { x: 0, y: 1 })) {
      updatePlayerPos({ x: 0, y: 1, collided: false });
    } else {
      if (player.pos.y < 1) {
        console.log('GAME OVER!!!');
        setGameOver(true);
        setDropTime(null);
      }
      updatePlayerPos({ x: 0, y: 0, collided: true });
    }
  };

  const playerRotate = (stage, dir) => {
    const clonedPlayer = JSON.parse(JSON.stringify(player));
    clonedPlayer.tetromino = clonedPlayer.tetromino.map((_, index) =>
      clonedPlayer.tetromino.map(col => col[index])
    );
    if (dir > 0) {
      clonedPlayer.tetromino = clonedPlayer.tetromino.map(row =>
        row.reverse()
      );
    } else {
      clonedPlayer.tetromino.reverse();
    }

    const pos = clonedPlayer.pos.x;
    let offset = 1;
    while (checkCollision(clonedPlayer, stage, { x: 0, y: 0 })) {
      clonedPlayer.pos.x += offset;
      offset = -(offset + (offset > 0 ? 1 : -1));
      if (offset > clonedPlayer.tetromino[0].length) {
        rotate(clonedPlayer, -dir);
        clonedPlayer.pos.x = pos;
        return;
      }
    }
    setPlayer(clonedPlayer);
  };


  return (
    <View style={styles.container}>
      <Text>Tetris</Text>
      <Stage stage={stage} />
      <Button title="New Game" onPress={startGame} />
      <View style={styles.controls}>
        <TouchableOpacity style={styles.controlButton} onPress={() => move(-1)}>
          <Text>Left</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.controlButton} onPress={() => move(1)}>
          <Text>Right</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.controlButton} onPress={() => playerRotate(stage, 1)}>
          <Text>Rotate</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  controls: {
    flexDirection: 'row',
    marginTop: 20,
  },
  controlButton: {
    backgroundColor: '#DDDDDD',
    padding: 10,
    margin: 5,
  },
});

export default GameScreen;
