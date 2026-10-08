
class PrimeCalculationResult {
  final int count;
  final Duration elapsed;

  const PrimeCalculationResult({required this.count, required this.elapsed});
}

bool isPrime(int n) {
  if (n <= 1) return false;

  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

PrimeCalculationResult countPrimes({int maxLimit = 5000000}) {
  final stopwatch = Stopwatch()..start();
  int primeCount = 0;

  for (int i = 2; i < maxLimit; i++) {
    if (isPrime(i)) {
      primeCount++;
    }
  }

  stopwatch.stop();
  return PrimeCalculationResult(
    count: primeCount,
    elapsed: stopwatch.elapsed,
  );
}