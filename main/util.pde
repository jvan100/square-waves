float easeInOutQuart(float value, float fromStart, float fromEnd, float toStart, float toEnd) {
    float t = (value - fromStart) / (fromEnd - fromStart); // Normalize input
    if (t < 0.5) {
        return toStart + (toEnd - toStart) * (8 * t * t * t * t);
    } else {
        return toStart + (toEnd - toStart) * (1 - pow(-2 * t + 2, 4) / 2);
    }
}

float easeInQuart(float value, float fromStart, float fromEnd, float toStart, float toEnd) {
    float t = (value - fromStart) / (fromEnd - fromStart); // Normalize input
    return toStart + (toEnd - toStart) * (t * t * t * t);
}

float easeOutQuart(float value, float fromStart, float fromEnd, float toStart, float toEnd) {
    float t = (value - fromStart) / (fromEnd - fromStart); // Normalize input
    t = 1 - t;
    return toStart + (toEnd - toStart) * (1 - (t * t * t * t));
}
