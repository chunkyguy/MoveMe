import { StyleSheet } from "react-native";
import {
  Gesture,
  GestureDetector,
  GestureHandlerRootView,
} from "react-native-gesture-handler";
import Animated, {
  useAnimatedStyle,
  useSharedValue,
  withSpring,
} from "react-native-reanimated";

function Square() {
  const isPressed = useSharedValue(false);
  const startPos = useSharedValue({ x: 0, y: 0 });
  const pos = useSharedValue({ x: 0, y: 0 });
  const animStyle = useAnimatedStyle(() => {
    return {
      backgroundColor: isPressed.value ? "red" : "blue",
      transform: [
        { translateX: pos.value.x },
        { translateY: pos.value.y },
        { scale: withSpring(isPressed.value ? 1.2 : 1) },
      ],
    };
  });

  const gesture = Gesture.Pan()
    .onBegin(() => {
      isPressed.value = true;
    })
    .onChange((e) => {
      pos.value = {
        x: startPos.value.x + e.translationX,
        y: startPos.value.y + e.translationY,
      };
    })
    .onFinalize(() => {
      isPressed.value = false;
      startPos.value = {
        x: pos.value.x,
        y: pos.value.y,
      };
    });

  return (
    <GestureDetector gesture={gesture}>
      <Animated.View style={[styles.square, animStyle]} />
    </GestureDetector>
  );
}

export default function App() {
  return (
    <GestureHandlerRootView style={styles.container}>
      <Square />
      <Square />
      <Square />
    </GestureHandlerRootView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "space-evenly",
  },
  square: {
    width: 100,
    height: 100,
    backgroundColor: "blue",
  },
});
