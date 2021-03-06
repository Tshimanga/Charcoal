/* Documentation for Charcoal */
module Charcoal {
  use Reflection;

  class UnitTest {

    var s: int,   // Number of passing tests
        f: int,   // Number of failing tests
        t: int,   // Number of tests total
        results: [1..0] TestResult;

    proc setUp() {}
    proc tearDown() {}

    proc init() {
      this.s = 0;
      this.f = 0;
    }

    proc report() {
      for r in this.results {
        /*
        //writeln(" ** TEST: ", r.passed , " ... ", r.msg);
        var m: string = " ** TEST: " + r.passed + " ... " + r.msg;
        writeln("r.type: ", r.type:string);
        if hasField(r.type, "expected") {
          writeln("EXPECTED!! ", r.expected);
        }
        //writeln(" ** TEST: ", r.passed , " ... ", r.msg, " expected: ", r.expected);
        writeln(m);
        */
        writeln(r.report());
        if r.passed {
          this.s += 1;
        } else {
          this.f += 1;
        }
      }
      writeln(" ** Passing: ", this.s, "\tFailing: ", f);
    }

    proc run() {
      setUp();
      tearDown();
      return 0;
    }

    proc assertIntEquals(msg: string, expected: ?, actual: ?) : TestResult {
      var b:bool = actual == expected;
      return new TestIntResult(msg=msg, passed=b, expected, actual);
    }

    proc assertRealEquals(msg: string, expected: ?, actual: ?) : TestResult {
      var b:bool = actual == expected;
      return new TestRealResult(msg=msg, passed=b, expected, actual);
    }

    proc assertArrayEquals(msg: string, expected: []?, actual: []?) : TestResult {
      return new TestArrayResult(msg=msg, passed=actual.equals(expected), expected, actual);
    }
  }

  class TestResult {
      var passed: bool = false,
          msg: string;

      proc init() {
        super.init();
        this.initDone();
      }

      proc init(msg: string, passed:bool) {
        super.init();
        this.initDone();
      }

      proc report() : string {
          var m: string = "\t** TEST: " + this.passed + " ... " + this.msg;
          return m;
      }
  }

  class TestIntResult : TestResult {
      var expected: int,
          actual: int;

      proc init(msg: string, passed: bool, expected: int, actual: int) {
        super.init();
        this.initDone();
        this.msg = msg;
        this.passed = passed;
        this.expected = expected;
        this.actual = actual;
      }

      proc report(): string
       {
          var m: string = super.report();
          if !this.passed {
            m += "\n\t\texpected: " + this.expected + "\n\t\tactual: " + this.actual;
          }
          return m;
      }
  }

  class TestRealResult : TestResult {
      var expected: real,
          actual: real;

      proc init(msg: string, passed: bool, expected: real, actual: real) {
        super.init();
        this.initDone();
        this.msg = msg;
        this.passed = passed;
        this.expected = expected;
        this.actual = actual;
      }

      proc report(): string
       {
          var m: string = super.report();
          if !this.passed {
            m += "\n\t\texpected: " + this.expected + "\n\t\tactual: " + this.actual;
          }
          return m;
      }
  }

  class TestArrayResult : TestResult {
    var expected: [1..0] real,
        actual: [1..0] real;

    proc init(msg: string, passed: bool, expected: [] real, actual: [] real) {
      super.init();
      this.initDone();
      this.msg = msg;
      this.passed=passed;
      for e in expected {
        this.expected.push_back(e);
      }
      //this.expected = for e in expected do e;
      //this.actual = for a in actual do a;
    }

  }
}
