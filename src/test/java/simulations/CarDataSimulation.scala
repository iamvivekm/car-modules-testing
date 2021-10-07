package simulations

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

import scala.concurrent.duration._
import scala.util.Properties

class CarDataSimulation extends Simulation {

  val userCount: Int = Properties.envOrElse("USER_COUNT", "1").toInt
  val duration: Int = Properties.envOrElse("DURATION", "1").toInt
  val protocol = karateProtocol()

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
  protocol.runner.karateEnv("perf")

  val engineStatus = scenario("create").exec(karateFeature("classpath:features/cardata/Capacity.feature@engineperf"))

  setUp(
    engineStatus.inject(rampUsers(userCount) during (duration seconds)).protocols(protocol)
  ).assertions(
    global.successfulRequests.percent.gt(98),
    global.failedRequests.percent.lt(2),
    global.responseTime.mean.lt(3000),
    global.responseTime.max.lt(3000)
  )

}